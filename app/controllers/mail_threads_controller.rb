class MailThreadsController < ApplicationController
  before_filter
  require "text_controller"

  def refresh
    ticket = Ticket.find(params[:ticket])
    last_update_date = (get_last_update_date_of ticket) - 1.days
    Gmail.connect!(ENV['GMAIL_USERNAME'], ENV['GMAIL_PASSWORD']) do |gmail|
      inbox_mails = gmail.mailbox('[Gmail]/All Mail').emails(:after => last_update_date, :from => ticket.client.email)
      inbox_mails.each do |mail|
        if mail_does_not_already_exist(mail)
          create_email_item(mail, ticket, ticket.client)
        end
      end
      outbox_mails = gmail.mailbox('[Gmail]/All Mail').emails(:after => last_update_date, :to => ticket.client.email)
      outbox_mails.each do |mail|
        if mail_does_not_already_exist(mail)
          create_email_item(mail,ticket, current_user)
        end
      end
    end
    redirect_to ticket
  end

  def remove_mail
    email_item = EmailItem.find(params[:mail])
    email_item.removed=TRUE
    email_item.save
    redirect_to email_item.email_thread.ticket
  end

  def remove_thread
    email_thread = EmailThread.find(params[:thread])
    email_thread.removed=TRUE
    email_thread.save
    redirect_to email_thread.ticket
  end

  def compose
    thread = EmailThread.find(params[:thread])
    message = params[:text]
    thread.email_items.new(prepared: TRUE, owner: current_user, content: message, new: 2)
    thread.save
    head 200
  end

  def edit
    email_item = EmailItem.find(params[:mail])
    email_item.content = params[:text]
    email_item.save
    head 200
  end

  def deliver
    email_item = EmailItem.find(params[:mail])
    Gmail.connect!(ENV['GMAIL_USERNAME'], ENV['GMAIL_PASSWORD']) do |gmail|
      email = gmail.compose do
        to email_item.email_thread.ticket.client.email
        subject email_item.email_thread.tags[0]
        text_part do
          body email_item.content.wiki_markup.to_wikitext
        end
        html_part do
          content_type 'text/html; charset=UTF-8'
          body email_item.content.wiki_markup.to_wikitext
        end
        #add_file "/path/to/some_image.jpg"
      end
      begin
        email.deliver!
      rescue
        flash[:error] = 'Error! Cannot Send Message.'
      end
      if not flash[:error]
        email_item.destroy
        flash[:success] = 'Message sent successfully! Synchronize to see new message'
      end
      redirect_to email_item.email_thread.ticket
    end
  end

  private
    def mail_does_not_already_exist(mail)
      EmailItem.find_by_uid(mail.uid) ? FALSE : TRUE
    end

    def create_email_item(mail, ticket, owner)
      thread = get_thread_for(normalized_subject_of(mail), ticket)
      plain_part = mail.multipart? ? (mail.text_part ? mail.text_part.body.decoded : nil) : mail.body.decoded
      plain_part = plain_part.gsub(/^>.*$/, "").
          gsub(/\n\n/,'<br>').
          gsub(/(\n|\r|<br>){2,}$/, '').
          gsub(/<\/p>\s*<br>\s*<p>/,'</p><p>').
          gsub(/--\s*/,'<br><i>') + '</i>'
      thread.email_items.new(new: 0,content: plain_part.gsub(/On (Sat|Sun|Mon|Tue|Wed|Thu|Fri), (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d+, \d+ at \d+:\d+ (PM|AM), [^(]*wrote:.*$/, ''), owner: owner, uid: mail.uid, created_at: DateTime.parse(mail.date.to_s))
      thread.save
    end

    def get_last_update_date_of(ticket)
      last_update_date = DateTime.parse('2000-01-01')
      ticket.email_threads.each do |thread|
        last_thread_date = DateTime.parse(thread.email_items.max_by{|i| i.created_at}.created_at.to_s)
        if last_update_date < last_thread_date
          last_update_date = last_thread_date
        end
      end
      last_update_date
    end

    def get_thread_for(subject, ticket)
      ticket.email_threads.each do |thread|
        if thread.tags.include? subject
          return thread
        end
      end
      ticket.email_threads.new(tags:[subject])
    end

    def normalized_subject_of(mail)
      subject = mail.subject.gsub(/Re(\[\d+\])*\s*:\s*/,'')
    end
end
