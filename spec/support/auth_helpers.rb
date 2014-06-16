module AuthHelpers
  def auth_with_user(user)
    request.cookies[:remember_token] = user.remember_token
  end

  def clear_token
    request.headers['remember_token'] = nil
  end
end