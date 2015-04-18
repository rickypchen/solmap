class GenabilityController < ApplicationController
  def data
        @baseline = HTTParty.get("https://api.genability.com/rest/v1/typicals/baselines/best?&zipCode=94702&buildingType=RESIDENTIAL",
        :headers => { "Authorization" => "Basic NjlmM2ZhNzktNzdiZC00NDA0LWI5NTItZDJkNzFkNzc5NjU0Ojg4MWVkODI2LWNlOTctNGUyYy05ZTljLTE4ZDg3ZDM5NGRkYQ==" }
        )
        @annualConsumption = @baseline['results'][0]["factors"]["annualConsumption"]
        @monthlyConsumption = @baseline['results'][0]["factors"]["monthlyConsumption"]
        @meanAnnualConsumption = @baseline['results'][0]["factors"]["meanAnnualConsumption"]
      @zipcode = 49001

    @tariff = HTTParty.get("https://api.genability.com/rest/public/tariffs?zipCode=#{@zipcode}",
        :headers => { "Authorization" => "Basic #{ENV['GENABILITY_HEADER']}"}
        )
    @tariff_rate = HTTParty.get("https://api.genability.com/rest/prices?zipCode=#{@zipcode}", :headers => { "Authorization" => "Basic #{ENV['GENABILITY_HEADER']}" })["results"][0]["rateMean"]
    render json: (@tariff_rate * @meanAnnualConsumption)
  end
end
