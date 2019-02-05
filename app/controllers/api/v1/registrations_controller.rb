module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      private

      def sign_up_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
