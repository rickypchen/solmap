class County < ActiveRecord::Base
	belongs_to :state
	has_many :zipcodes

	validates_uniqueness_of :name, scope: :state_id

  def sample_zipcode
    self.zipcodes.first.code
  end
end
