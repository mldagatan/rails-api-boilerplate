module Api
  module V1
    class ApiController < ApplicationController
      include Api::Concerns::ApiRequest
      before_action :check_json_request

      layout false
      respond_to :json
    end
  end
end
