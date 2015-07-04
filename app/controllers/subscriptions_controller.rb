class SubscriptionsController < ApplicationController
  skip_before_filter :authenticate_user!

  before_filter :load_plans

  def index
  end

  def new
    @subscription = Subscription.new
    @plan = Plan.find(params[:plan_id])
  end

  def create
    @plan = Plan.find(params[:plan_id])
    #Rails.logger.info "We have a plan.."
    @subscription = CreateSubscription.call(
        @plan,
        params[:email_address],
        params[:stripeToken]
    )
    #Rails.logger.info "We have a subscription.."
    if @subscription.errors.blank?
      Rails.logger.info "We have no errors.."
      flash[:notice] = 'Thank you for your purchase!' +
          'Please click the link in the email we just sent ' +
          'you to get started.'
      redirect_to '/'
    else
      Rails.logger.info "We have a problem.."
      render :new
    end
  end

  protected

  def load_plans
    @plans = Plan.all.order('amount')
    @plans.each do |row|
      Rails.logger.info "Looping through the Plans.."
      Rails.logger.info row.inspect
    end
  end

end