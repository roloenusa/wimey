class User < ActiveRecord::Base
  
  has_many :tasks
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
  
  def get_tasks_by_status(start_date = 0, end_date = 10**10, status = 1)
    tasks.active
  end
         
  def get_tasks_by_date(start_date = 0, end_date = 10**10)
    tasks.where('start_date > ? AND end_date < ?', start_date, end_date)
  end    
  
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.find_by_email(data["email"])

    unless user
      user = User.create(name: data["name"], email: data["email"], password: Devise.friendly_token[0,20])
    end
    user
  end
end
