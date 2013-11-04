class Subscription < ActiveRecord::Base
  attr_accessible :plan_id, :user_id, :email, :stripe_card_token, :coupon, :last_4_digits
  attr_accessor :stripe_card_token

  belongs_to :plan
  belongs_to :user
  validates :email, :presence => true
  validates :plan_id, :presence => true
  validates :user_id, :presence => true

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(:email => email, :plan => plan.stripe_plan_id, :card => stripe_card_token)
      self.stripe_customer_token = customer.id
      self.last_4_digits = customer.active_card.last4
      save!
#      self.company.check_activations
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem creating your subscription. #{e.message}."
    false
  end

  def update_plan(new_plan)
    unless stripe_customer_token.nil?
      customer_id = stripe_customer_token
      customer = Stripe::Customer.retrieve(customer_id)
      customer.update_subscription(:plan => new_plan.stripe_plan_id)
#      self.company.check_activations
#      plan_updated_email
    end
    true
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end

  def update_card
    unless stripe_customer_token.nil?
      customer_id = stripe_customer_token
      customer = Stripe::Customer.retrieve(customer_id)
      if stripe_card_token.present?
        customer.card = stripe_card_token
      end
      customer.email = email
      customer.save
    end
    self.last_4_digits = customer.active_card.last4
    save!
    true
#    card_updated_email
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end

  def cancel_subscription
    unless stripe_customer_token.nil?
      customer_id = stripe_customer_token
      customer = Stripe::Customer.retrieve(customer_id)
      unless customer.nil? or customer.respond_to?('deleted')
        if customer.subscription.status == 'active' or customer.subscription.status == 'trialing'
          customer.cancel_subscription
        end
      end
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}."
    false
  end

  def plan_updated_email
    UserMailer.email_user_plan_updated(self).deliver
  end

  def card_updated_email
    UserMailer.email_user_card_updated(self).deliver
  end

end
