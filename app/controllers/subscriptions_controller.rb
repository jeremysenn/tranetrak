class SubscriptionsController < ApplicationController
  load_and_authorize_resource

  def index
    @subscriptions = Subscription.all
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def new
    plan = Plan.find(params[:plan_id])
    @subscription = plan.subscriptions.build
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save_with_payment
#      redirect_to @subscription, :notice => "Thank you for subscribing!"
      redirect_to '/', :notice => "Thank you for subscribing!"
    else
      render :action => 'new'
    end
  end

  def edit
    @subscription = Subscription.find(params[:id])
#    plan = Plan.find(params[:plan_id])
#    @subscription.plan = plan
  end

  def update
    @subscription = Subscription.find(params[:id])
    new_plan = Plan.find(params[:subscription][:plan_id]) unless params[:subscription][:plan_id].nil?
    stripe_card_token = params[:subscription][:stripe_card_token]
    if @subscription.update_attributes(params[:subscription])
      @subscription.update_plan(new_plan) unless new_plan.nil?
      @subscription.update_card unless stripe_card_token.nil?
      redirect_to edit_subscription_path(@subscription), :notice  => "Successfully updated subscription."
    else
      flash.alert = 'Unable to update card.'
      render :action => 'edit'
    end


#    @subscription = Subscription.find(params[:id])
#    if @subscription.update_attributes(params[:subscription])
#      redirect_to '/', :notice  => "Successfully updated subscription."
#    else
#      render :action => 'edit'
#    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    redirect_to subscriptions_url, :notice => "Successfully destroyed subscription."
  end
end
