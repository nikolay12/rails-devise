Rails.configuration.stripe = {
    publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
    secret_key:      ENV['STRIPE_SECRET_KEY']
    #currency: ENV['STRIPE_CURRENCY'],
    #trial_period: ENV['STRIPE_TRIAL_PERIOD']
}

Stripe.api_key = \
  Rails.configuration.stripe[:secret_key]