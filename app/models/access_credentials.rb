class AccessCredentials < ActiveRecord::Base
  attr_accessible :properties
  has_many :properties, as: :owner

  def find_property(name)
    self.properties.each do |property|
      return property if name.eql? property.name
    end
    nil
  end

  def ftp
    find_property "ftp"
  end

  def ssh
    find_property "ssh"
  end

  def cpanel
    find_property "cpanel"
  end

  def admin
    find_property "admin"
  end
end
