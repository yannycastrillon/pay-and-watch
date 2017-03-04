class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  attr_accessor :stripe_card_token


  # process payment with Stripe
  def save_with_payment
    if valid?
      ActiveRecord::Base.transaction do
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
        video_amount = Video.find(self.video_id).price
        Stripe::Charge.create customer: customer.id,
                            amount: (video_amount * 100).round,
                            description: "First Payment",
                            currency: 'usd'
      end
    end   
  end
end
