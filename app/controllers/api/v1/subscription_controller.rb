class Api::V1::SubscriptionController < ApplicationController
  def new
    tea = Tea.find_by(name: params[:tea_name])
    customer = Customer.find_by(email: params[:email])
    sub = Subscription.create!(subscription_id: SecureRandom.hex, monthly_fee: params[:monthly_fee], status: 1,
                           frequency: params[:frequency], tea:, customer:)

    render json: SubscriptionSerializer.new(sub)
  end

  def cancel
    sub = Subscription.find_by(subscription_id: params[:subscription_id])
    sub.update!(status: 0)
    render json: SubscriptionSerializer.new(sub)
  end

  def index
    customer = Customer.find_by(email: params[:email])
    subs = customer.subscriptions
    render json: SubscriptionSerializer.new(subs)
  end
end
