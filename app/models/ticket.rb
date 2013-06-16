class Ticket < ActiveRecord::Base
  attr_accessible :site, :client, :name, :tasks, :attachments, :email_threads, :properties, :state
  belongs_to :client
  has_many :tasks
  has_many :attachments, through: :tasks
  has_many :email_threads
  has_many :properties, as: :owner

  NEW = 'New'
  QUOTE = 'Quote'
  ORDER = 'Order'
  IMPLEMENTATION = 'Implementation'
  TESTING = 'Testing'
  CLIENT_CONSENT = 'Client-Consent'
  DELIVERING = 'Delivering'
  SUPPORT = 'Support'
  INVALID = 'Invalid'
  ALL = 'All'

  STATES = [NEW, QUOTE, ORDER, IMPLEMENTATION, TESTING, CLIENT_CONSENT, DELIVERING, SUPPORT]

  is_done= lambda{|ticket|
    ok=true
    ticket.tasks.each{|task|
      if task.get_current_state != 'accepted'
        ok=false
        break
      end
    }
    ok
  }

  TRANSITIONS={
      NEW=> [{:name=>'Start Quote', :to=>QUOTE},
             {:name=>'Ready for implement', :to=>ORDER},
             {:name=>'Accept', :to=>IMPLEMENTATION}],
      QUOTE=> [{:name=>'Ready for implement', :to=>ORDER},
               {:name=>'Accept', :to=>IMPLEMENTATION}],
      ORDER=> [{:name=>'Accept', :to=>IMPLEMENTATION}],
      IMPLEMENTATION=> [{:name=>'Resolve', :to=>TESTING, :filters=>[{:filter=>is_done, :error_message=>'Not all tasks have passed the test'}]}],
      TESTING=> [{:name=>'Approve', :to=>CLIENT_CONSENT},
                 {:name=>'Reject', :to=>ORDER}],
      CLIENT_CONSENT=> [{:name=>'Client Approve', :to=>DELIVERING},
                        {:name=>'Client Reject', :to=>ORDER}],
      DELIVERING=> [{:name=>'Close', :to=>SUPPORT},
                    {:name=>'Reopen', :to=>ORDER}],
      SUPPORT=>[{:name=>'Reopen', :to=>ORDER}],
      INVALID=>[],
      ALL=>[{:name=>"Make New", :to=>NEW},
            {:name=>"Invalid", :to=>INVALID}]
  }
end
