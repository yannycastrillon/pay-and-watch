class PaymentsController < ApplicationController
  def index
  end

  def show
  end

  #TODO To buy a video you must login of create an account "Sign in"
  def new
    if not current_user
      redirect_to new_session_path, flash: {:alert => "Warning! Must be Login to purchase a video!"}
    else
      # prepopulates form with the current_user's email.
      @payment = Payment.new(email_address: current_user.email)
      @video = Video.find(params[:v_id])
    end
  end

  def create

    current_user.payments.create(secure_params)
  end

  private

  def secure_params
    params.require(:payment).permit(:card_holder_name, :card_number, :exp_date,:card_sec_code,
                                    :billing_address,:city,:state_province,:postal_code, :email_address,:video_id)
  end
end
