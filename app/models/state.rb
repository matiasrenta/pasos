class State < ActiveRecord::Base
  has_many :therapists
  has_many :patients
  has_many :users

  validates_presence_of :name

  def self.active
    find_by_i18n_name("active")
  end

  def self.inactive
    find_by_i18n_name("inactive")
  end


  def name
    I18n.t 'activerecord.i18n_name.state.' + self.i18n_name
  end

end
