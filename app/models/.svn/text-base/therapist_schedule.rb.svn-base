class TherapistSchedule < ActiveRecord::Base
  belongs_to :therapist
  belongs_to :state
  has_and_belongs_to_many :therapies, :join_table => "therapy_schedule_joins"

  validates_presence_of :dia, :hora, :state_id
  validates_uniqueness_of :dia, :scope => [:hora, :therapist_id]

  scope :available_hours, lambda {|t_id| where(:therapist_id => t_id, :state_id => State.active).where("not exists
                                                                                                        (select *
                                                                                                           from therapies t, therapy_schedule_joins tsj
                                                                                                          where t.state_id = 1
                                                                                                            and tsj.therapist_schedule_id = therapist_schedules.id
                                                                                                            and t.id = tsj.therapy_id)").order(:dia, :hora) }

  def name
    "#{I18n.translate("date.day_names")[dia]} #{hora}hs"
  end
end
