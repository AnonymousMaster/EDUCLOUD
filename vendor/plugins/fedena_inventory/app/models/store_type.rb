class StoreType < ActiveRecord::Base
  validates_presence_of:name,:code
  belongs_to :store
  
end
