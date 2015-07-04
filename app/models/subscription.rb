class Subscription < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :plan, required: true
  belongs_to :card, required: true

  has_paper_trail
end
