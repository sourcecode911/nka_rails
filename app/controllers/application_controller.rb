class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Protect app on cloud from unwanted access
  # before_action :authorize
  before_action :authenticate_user!

  # Http Basic Protection
  def authorize
    return true unless Rails.env.production?
    authenticate_or_request_with_http_basic do |user, password|
      (user == 'nka' && password == 'nka-test')
    end
  end
end
