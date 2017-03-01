class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  attr_accessor :stripe_card_token


  # process payment with Stripe
  def save_with_payment
    if valid?
      payment_db = Payment.find_by_email(self.email)
      # validate if payment already has a customer_token
      if payment_db.stripe_customer_token.present?
        # Retrieves existing customer Stripe
        customer = Stripe::Customer.retrieve(self.stripe_customer_token)
      else
        # Creates a new Customer on my Stripe account
        customer = Stripe::Customer.create(description: email,card: stripe_card_token)
        self.stripe_customer_token = customer.id
        save!
      end
    end
    Stripe::Charge.create customer: customer.id,
                          amount: 3 * 100,
                          description: "First Payment",
                          currency: 'usd'
  end
end
