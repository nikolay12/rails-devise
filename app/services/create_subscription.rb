class CreateSubscription
  def self.call(plan, email_address, token)

    user, raw_token = CreateUser.call(email_address)
    subscription = Subscription.new(
        plan: plan,
        user: user
    )

    begin
      stripe_sub = nil
      cc = nil
      if user.stripe_customer_id.blank?
        customer = Stripe::Customer.create(
            source: token,
            email: user.email,
            plan: plan.stripe_id,
        )
        user.stripe_customer_id = customer.id
        user.save!
        stripe_sub = customer.subscriptions.first

        cc = customer.sources.data[0]
        Rails.logger.info "CC's last 4 digits: " + cc.last4
      else
        customer = Stripe::Customer.retrieve(user.stripe_customer_id)
        stripe_sub = customer.subscriptions.create(
            plan: plan.stripe_id
        )
        cc = customer.sources.data.last
        Rails.logger.info "CC's last 4 digits: " + cc.last4
      end

      card = Card.new
      card.brand = cc.brand
      card.last4 = cc.last4
      card.country = cc.country
      card.exp_month = cc.exp_month
      card.exp_year = cc.exp_year
      card.fingerprint =  cc.fingerprint
      card.funding = cc.funding
      card.user = user
      card.save!

      Rails.logger.info "CC saved!"

      subscription.stripe_id = stripe_sub.id
      subscription.card = card
      subscription.save!

      Rails.logger.info "Subscription saved!"

    rescue Stripe::StripeError => e
      subscription.errors[:base] << e.message
    end

    subscription
  end
end