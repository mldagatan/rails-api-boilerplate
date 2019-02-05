module Api
  module V1
    class ApiController < ApplicationController
      include Api::Concerns::ApiRequest

      respond_to :json
    end
  end
end
