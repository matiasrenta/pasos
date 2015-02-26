class Role < ActiveRecord::Base
  default_scope order("position")

  has_many :users

  def self.admin
    find_by_i18n_name("admin")
  end


  def name
    I18n.t 'activerecord.i18n_name.Role.' + self.i18n_name
  end


end