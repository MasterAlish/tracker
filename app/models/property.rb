class Property < ActiveRecord::Base
  attr_accessible :name, :data
  serialize :data, Hash
  belongs_to :owner, polymorphic: true
end
