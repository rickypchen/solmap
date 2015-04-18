require 'httparty'

class SolarResourceController < ApplicationController
	def index

	end

	def get_data
		base_url = "/api/solar/solar_resource/v1.json?"
		address = "91803"
		api_key = ENV['NREL_KEY']
		# address is a placeholder NEEDS to get
		# address from params or input

		options = {
			query: {
				api_key: api_key,
				address: address,
			}
		}

		response = HTTParty.get(base_url, options)
		p response
		render json: response
	end

end
