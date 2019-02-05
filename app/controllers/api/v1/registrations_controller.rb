module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      private

      def sign_up_params
        params.require(:user).permit(:email, :password)
      end

      def account_update_params
        params.require(:user).permit(
          :email, :password, :password_confirmation, :username, :first_name,
          :last_name, :nickname
        )
      end
    end
  end
end
