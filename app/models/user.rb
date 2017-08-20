class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events
  has_many :calendars

  after_create :create_calendar

  def author_of?(entity)
    entity.user_id == id
  end

  private

  def create_calendar
    self.calendars.create
  end
end
