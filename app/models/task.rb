class Task < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :project
  
  scope :before,    ->(end_time) { where ["end_date < ?", Task.format_date(end_time)] }
  scope :after,     ->(start_date) { where ["start_date > ?", Task.format_date(start_time)] }
  scope :status,    ->(current_status) { where status: current_status}
  scope :active,    -> { status(STATUS[:active]) }
  scope :inactive,  -> { status(STATUS[:inactive]) }
  scope :completed, -> { status(STATUS[:completed]) }
  
  STATUS = {
    :inactive   => 0,
    :active     => 1,
    :completed  => 2
  }
  
  before_save :set_user_by_email
  
  attr_accessor :project_name
  
  def project_name
    project ? project.name : nil
  end
  
  def set_user_by_email
    self.user_id = User.find_by_email(self.user_email).id
    self.user_email = self.user_email
  end
  
  def as_json(options = {})
    {
      :id => self.id,
      :user_id => self.user_id,
      :created_by => self.created_by,
      :title => self.title,
      :description => self.description || "",
      :start => start_date.rfc822,
      :end => end_date.rfc822,
      :allDay => false,
      :recurring => false,
      :status => self.status,
      :url => Rails.application.routes.url_helpers.task_path(id)
    }

  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
end
