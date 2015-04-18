class Zipcode < ActiveRecord::Base
	belongs_to :county
	validates :code, uniqueness: true, presence: true
end
