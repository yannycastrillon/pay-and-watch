class PaymentsController < ApplicationController
  def index
  end

  def show
  end

  def new
    if not current_user
      redirect_to new_session_path, flash: {:alert => "Warning! Must be Login to purchase a video!"}
    else
      # prepopulates form with the current_user's email.
      @payment = Payment.new(email: current_user.email)
      @video = Video.find(params[:v_id])
    end
  end

  def create
    if not current_user
      redirect_to new_session_path, flash: {:alert => "Warning! Must be Login to save a video!"}
    else

      # stripe_card_token, exp_month, exp_year,
      @payment = Payment.new secure_params
      @payment.user_id = current_user.id
      
      @payment.save_with_payment
      # asdfasf
      # current_user.payments.create(secure_params)
      redirect_to user_path(current_user)
    end
  end

  private

  def secure_params
    params.require(:payment).permit(:card_holder_name, :card_sec_code, :address, :city, :state_province, :postal_code, :email, :video_id, :stripe_card_token, :exp_month, :exp_year)
  end

end
