module ActiveInactiveExtension
  def self.included(base)
    base.extend(ClassMethods)
  end

  #Class Methods
  module ClassMethods
    def actives
      with_scope do
        where("state_id = ?", State.active.id)
      end
    end

    def inactives
      with_scope do
        where("state_id = ?", State.inactive.id)
      end
    end
  end


  #Instance Methods
  def active?
    state == State.active
  end

  def inactive?
    state == State.inactive
  end

end

ActiveRecord::Base.send(:include, ActiveInactiveExtension)