class Plan < ActiveRecord::Base
  #Just a reference to the Stripe plan; needed to handle relation integrity for subscriptions,
  # amount is at all persisted locally because it might (or not) be useful later on
  validates :amount, presence: true, numericality: true
  validates :stripe_id, presence: true, uniqueness: true

  def readonly? #Stripe allows only name change - and even this is dangerous
    !new_record?
  end

  #TODO: need to add 'active' field to limit the subscriptions only to those; the field needs to be writable!

end