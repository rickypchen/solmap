require 'httparty'

class SolarResourceController < ApplicationController
	def index

	end

	def data
		base_url = "https://developer.nrel.gov/api/solar/solar_resource/v1.json?"
		ca_state_id = 5
		ca_counties = County.where(state_id: ca_state_id)
		api_key = ENV['NREL_KEY']

		ca_counties.each do |county|
			options = {
				query: {
					api_key: api_key,
					address: county.sample_zipcode,
				}
			}

			@solar_response = HTTParty.get(base_url, options)
			p outputs = @solar_response["outputs"]
			avg_dni = outputs["avg_dni"]["annual"]
			avg_ghi = outputs["avg_ghi"]["annual"]
			avg_lat_tilt = outputs["avg_lat_tilt"]["annual"]

			county.irradiance_dni = avg_dni
			county.irradiance_ghi = avg_ghi
			county.irradiance_lat_tilt = avg_lat_tilt
			county.save!

		end

		render json: @solar_response

	end


end
