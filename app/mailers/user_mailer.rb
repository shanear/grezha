class UserMailer < ActionMailer::Base
  def forgot_password_email(user, reset_password_url)
    @user = user
    @reset_password_url = reset_password_url

    mail(
      to: @user.email,
      from: "no-reply@grezha.com",
      subject: "Password reminder for Grezha"
    );
  end
end