class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  attr_accessor :stripe_card_token


  # process payment with Stripe
  def save_with_payment
    if valid?
      ActiveRecord::Base.transaction do
        payment_db = Payment.find_by_email(self.email)
        if payment_db != nil
          # validate payment already has a customer_token
          if payment_db.stripe_customer_token.present?
            # Retrieves existing customer Stripe
            @customer = Stripe::Customer.retrieve(payment_db.stripe_customer_token)
          else
            self.create_stripe_customer
          end
        else
          self.create_stripe_customer
        end
        self.charge_stripe_customer
        save!
      end
    end
  end

  # Creates a new Customer on my Stripe account
  def create_stripe_customer
    @customer = Stripe::Customer.create(description: email,card: stripe_card_token)
    self.stripe_customer_token = @customer.id
  end

  # Charge amount to stripe customer
  def charge_stripe_customer
    video_amount = Video.find(self.video_id).price
    Stripe::Charge.create customer: @customer.id,
                          amount: (video_amount * 100).round,
                          description: "First Payment",
                          currency: 'usd'
  end
end
