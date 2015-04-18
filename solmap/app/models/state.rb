class State < ActiveRecord::Base
	has_many :zipcodes
	validates :abbrev, :name, uniqueness: true
end
