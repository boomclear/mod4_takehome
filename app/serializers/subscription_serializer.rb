class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :subscription_id, :monthly_fee, :status, :frequency

  attribute :tea do |object|
    object.tea.name
  end

  attribute :customer do |object|
    object.customer.email
  end
end
