class Patient < ActiveRecord::Base
  belongs_to :state
  has_many :therapies
  has_many :payments
  has_many :assessments

  has_many :services
  has_many :fixed_therapies
  has_many :time_ranges

  before_validation :on => :update do
    therapies.each do |therapy|
      if therapy.marked_for_destruction? && !therapy.destroyable?
        therapy.reload
        errors.add(:base, "Existen asistencias registradas para la terapia con #{therapy.therapist.nombre}, debe inactivarla")
      end
    end
  end

  validates_presence_of :nombre, :nombre_padre, :nombre_madre, :costo_terapia, :saldo, :state_id, :nombre_empresa, :direccion, :colonia, :delegacion, :cp, :ciudad, :email_empresa, :rfc
  validates_presence_of :motivo_alta, :if => "!fecha_alta.blank?"
  validates_presence_of :cel_padre, :if => "cel_madre.blank?", :message => "Debe ingresar algún celular"
  #validates_presence_of :recibo_donativo, :if => "!factura", :message => "debe ser Donativo o Factura"
  validate :recibo_donativo do
    errors.add(:recibo_donativo, "no puede ser Donativo y Factura") if recibo_donativo && factura
  end
  validate :state do
    errors.add(:state, "Si tiene fecha de alta debe inactivarlo") if state == State.active && fecha_alta
  end

  accepts_nested_attributes_for :therapies, :allow_destroy => true
  accepts_nested_attributes_for :assessments, :allow_destroy => true

  before_validation :set_saldo_and_therapy_cost
  before_save :validate_uniqueness_therapies_lines#, :on => :create
  after_save :inactive_therapies

  def costo_terapia_with_tax
    factura ? costo_terapia * Settings.mas_iva : costo_terapia
  end

  private

  def set_saldo_and_therapy_cost
    self.saldo = 0 if !saldo
    self.costo_terapia = 0 if !costo_terapia
  end

  def inactive_therapies
    therapies.update_all( {:state_id => State.inactive.id},  {:state_id => State.active.id} ) if inactive?
  end

  def validate_uniqueness_therapies_lines
    uniq_array = therapies.uniq_by{|t| t.therapist_id}
    if uniq_array.size == therapies.size
      return true
    end
    errors.add(:base, "Existen terapias repetidas")
    return false
  end
end
