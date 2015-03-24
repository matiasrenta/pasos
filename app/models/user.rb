class User < ActiveRecord::Base
  #default_scope order("users.name, last_name, mother_last_name")

  belongs_to :state
  belongs_to :role
  has_many :cancellations
  validates_presence_of :name, :last_name, :email, :role_id, :state_id
  validate :email,  :length => {:minimum => 3, :maximum => 100},
                    :uniqueness => true,
                    :email => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable#, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :reset_password_token, :role_id, :name, :last_name, :mother_last_name,
                  :work_phone, :home_phone, :cell_phone, :state_id

  default_scope order(:name, :last_name)

  def full_name
    "#{name} #{last_name}"
  end


  def admin?
    self.role == Role.admin
  end



  def active?
    state == State.active
  end

  def inactive?
    state == State.inactive
  end


  def active_for_authentication?
    super && active?
  end

  def inactive_message
    active? ? super : "El usuario está inactivo"
  end



end


