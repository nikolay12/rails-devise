class Subscription < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :plan, required: true
end
