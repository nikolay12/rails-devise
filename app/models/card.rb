class Card < ActiveRecord::Base
  belongs_to :user, required: true
  has_many :subscriptions
  validates :user_id, uniqueness: {scope: :fingerprint} #a user should not enter the same card twice?
end
