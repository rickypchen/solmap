require 'rails_helper'

RSpec.describe SolarResourceController, type: :controller do

	describe 'GET #data' do 
		before(:each) do 
			get :data, zip: "91803"
		end

		it 'should make a request to api and get response' do 
			expect(response.status).to eq(200)
			expect(response.body).to include ('address')
			expect(response.body).to include ('annual')
			# expect(["outputs"]["avg_dni"]["annual"]).to eq 5.73
		end

		it "should save info to database based on zip"

	end


end
