class County < ActiveRecord::Base
	belongs_to :state
	has_many :zipcodes

	validates_uniqueness_of :name, scope: :state_id

  def sample_zipcode
    self.zipcodes.first.code
  end

  def irradiance_data
    base_url = "https://developer.nrel.gov/api/solar/solar_resource/v1.json?"
    api_key = ENV['NREL_KEY']

    options = {
            query: {
              api_key: api_key,
              address: self.sample_zipcode,
      }
    }

      solar_response = HTTParty.get(base_url, options)
      outputs = solar_response["outputs"]
      avg_dni = outputs["avg_dni"]["annual"]
      avg_ghi = outputs["avg_ghi"]["annual"]
      avg_lat_tilt = outputs["avg_lat_tilt"]["annual"]

      self.irradiance_dni = avg_dni
      self.irradiance_ghi = avg_ghi
      self.irradiance_lat_tilt = avg_lat_tilt
      self.save!
  end

  def genability_data
    zipcode = self.sample_zipcode

    baseline = HTTParty.get("https://api.genability.com/rest/v1/typicals/baselines/best?&zipCode=#{zipcode}&buildingType=RESIDENTIAL",
    :headers => { "Authorization" => "Basic #{ENV['GENABILITY_HEADER']}" }
    )
    meanAnnualConsumption = baseline['results'][0]["factors"]["meanAnnualConsumption"]
    tariff_rate = HTTParty.get("https://api.genability.com/rest/prices?zipCode=#{zipcode}", :headers => { "Authorization" => "Basic #{ENV['GENABILITY_HEADER']}" })["results"][0]["rateMean"]

    avg_annual_cost = tariff_rate * meanAnnualConsumption
    self.avg_annual_cost = avg_annual_cost
    self.save!
  end
end
