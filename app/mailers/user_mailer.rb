class UserMailer < ApplicationMailer
    default from: 'egiatrading@gmail.com'

    def welcome_email
      @user = params[:user]
      @url  = 'http://example.com/login'
      mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end

    def declined_account
        @user = params[:user]
        mail(to: @user.email, subject: 'Account has been declined')
    end
end
