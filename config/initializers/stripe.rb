#store the environment variables on the Rails.configuration object
Rails.configuration.stripe = {
	publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
	secret_key: ENV['STRIPE_SECRET_KEY']
}

#set our app-stored secret key with stripe
Stripe.api_key = Rails.configuration.stripe[:secret_key]
