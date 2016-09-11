class UserMailer < ActionMailer::Base
#  default :from => "notifications@tranetrak.com"
  
  def email_user_plan_updated(subscription)
    @subscription = subscription
    mail(:to => subscription.email, :subject => "Subscription Plan Updated")
  end

  def welcome(user)
    mail(:to => user.email, :subject => "Welcome to tranetrak.com!")
  end

  def new_bodycomp_completed(bodycomp)
    @bodycomp = bodycomp
    @client = bodycomp.client
    @user = bodycomp.client.trainer.user
    mail to: @client.email,
#    mail to: 'senn.jeremy@gmail.com',
      cc:    @user.email,
      from:  @user.email,
    subject: "#{@client.full_name} - Body Composition Assessment Results"
  end
end