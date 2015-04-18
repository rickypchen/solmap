class Zipcode < ActiveRecord::Base
	belongs_to :state
	validates :code, uniqueness: true, presence: true
end
