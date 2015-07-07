class StoreCardMeta
  def self.call(user, cmeta)

    card = Card.find_or_create_by!(user: user, fingerprint: cmeta.fingerprint)

    if !card.last4 # last4 is NULL

      Rails.logger.info "New CC.."

      card.brand = cmeta.brand
      card.last4 = cmeta.last4
      card.country = cmeta.country
      card.exp_month = cmeta.exp_month
      card.exp_year = cmeta.exp_year
      card.funding = cmeta.funding
      card.save!
    else
      Rails.logger.info "Old CC.."
    end

    Rails.logger.info "CC saved!"

    card
  end
end