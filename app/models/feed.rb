class Feed < ActiveRecord::Base
  # Remember to create a migration!
  validates :feedid, uniqueness: true

end
