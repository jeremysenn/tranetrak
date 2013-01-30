class UserMailer < ActionMailer::Base
  default :from => "notifications@tranetrak.com"
  
  def email_user_plan_updated(subscription)
    @subscription = subscription
    mail(:to => subscription.email, :subject => "Subscription Plan Updated")
  end

  def welcome(user)
    mail(:to => user.email, :subject => "Welcome to tranetrak.com!")
  end
end