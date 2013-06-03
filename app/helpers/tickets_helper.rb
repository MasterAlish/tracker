module TicketsHelper
  def can_modify
    if cannot?(:modify, Ticket)
      redirect_to session[:user_return_to]
    end
  end
end
