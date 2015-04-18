class ChargesController < ApplicationController

    def create
      #creates a stripe customer object, for associating with the charge
	  customer = Stripe::Customer.create(
	  	email: current_user.email,
	  	card: params[:stripeToken]
	  )

	  #Where the real magic happens
	  charge = Stripe::Charge.create(
	  	customer: customer.id, #Note -- this is NOT the user_id in your app
	  	amount: Amount.default,
	  	description: "BigMoney Membership - #{current_user.email}",
	  	currency: 'usd'
	  	)
	  current_user.update_attribute(:role, 'premium')
	  flash[:success] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again!"
	  redirect_to root_url

	  #Stripes friendly error blocks

	rescue Stripe::CardError => e 
		flash[:error] = e.message
		redirect_to new_charge_path
    end

    def new
    	@stripe_btn_data = {
    		key: "#{ Rails.configuration.stripe[:publishable_key] }",
    		description: "BigMoney Membership - #{current_user.email}",
    		amount: Amount.default

    		}
    end
private

  class Amount
  	@default_amount = 15_00
  	  def self.default
  		@default_amount
  	  end
  end


end
