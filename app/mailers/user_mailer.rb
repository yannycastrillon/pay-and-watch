class UserMailer < ApplicationMailer
  default from: "yannyandres117@gmail.com"

  def activate_email(user)
    @user = user
    @url = "http://localhost:3000/sessions/new"
    mail(to: "yannyandres117@gmail.com", subject: "Pay-And-Watch notification to activate account")
  end
end
