# The secret test API Key (secret key)
Stripe.api_key = ENV["TEST_SECRET_KEY"]

Rails.configuration.stripe = {
    :publishable_key => Rails.application.secrets.stripe_publishable_key,
    :secret_key      => Rails.application.secrets.stripe_secret_key
}
