class UserMailer < ApplicationMailer
    default from: 'egiatrading@gmail.com'

    def approved_email
      @user = params[:user]
      @url  = 'http://example.com/login'
      mail(to: @user.email, subject: 'Your account has been approved')
    end

    def declined_account
        @user = params[:user]
        mail(to: @user.email, subject: 'Account has been declined')
    end

    def deleted_account
      @user = params[:user]
      mail(to: @user.email, subject: "Account has been deleted")
    end
end
