class State < ActiveRecord::Base
	has_many :counties
	validates :abbrev, :name, uniqueness: true
end
