class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  %w(Student Teacher).each do |k|
    define_method "current_#{ k.underscore }" do
      current_user if current_user.is_a?(k.constantize)
    end

    define_method "authenticate_#{ k.underscore }!" do
      |opts={}| send("current_#{ k.underscore }") || not_found
    end

    define_method "#{ k.underscore }_signed_in?" do
      !send("current_#{ k.underscore }").nil?
    end
  end
end
