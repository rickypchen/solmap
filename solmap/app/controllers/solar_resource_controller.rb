require 'httparty'

class SolarResourceController < ApplicationController
	def index

	end

	def data
		base_url = "https://developer.nrel.gov/api/solar/solar_resource/v1.json?"
		address = params[:county]
		api_key = ENV['NREL_KEY']
		# address is a placeholder NEEDS to get
		# address from params or input

		options = {
			query: {
				api_key: api_key,
				address: address,
			}
		}

		@solar_response = HTTParty.get(base_url, options)
		render json: @solar_response
	end

end
