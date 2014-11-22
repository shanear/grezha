class UserMailer < ActionMailer::Base
  def forgot_password_email(user, reset_password_url)
    @user = user
    @reset_password_url = reset_password_url

    mail(
      to: @user.email,
      from: "shane@grezha.org",
      subject: "Password reset link for Grezha"
    );
  end

  def new_user_email(user, url)
    @user = user
    @password = @user.password
    @organization_name = @user.organization.name
    @url = url

    mail(
      to: @user.email,
      from: "shane@grezha.org",
      subject: "You've been added to the Grezha account for #{@organization_name}"
    );
  end
end