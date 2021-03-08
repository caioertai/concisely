class Lesson < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :industry, presence: true

  INDUSTRIES = [
    "engineering",
    "marketing",
    "banking & finance",
    "accounting & legal",
    "sports",
    "software development",
    "information technology",
    "education",
    "healthcare",
    "retail",
    "government",
    "construction & maintenance",
    "manufacturing",
    "other"
  ]

  def price_display
    "$#{self.price}/#{self.duration} min"
  end

  def available_hours_for(date)
    hours_for_booking.reject do |time|
      booked_times_for(date).include?(time)
    end
  end

  private

  def booked_times_for(date)
    bookings
      .for(date)
      .pluck(:start_time)
      .map(&:to_datetime)
  end

  def slots_count_possible_per_day
    (12 * 60).minutes / duration.minutes
  end

  def hours_for_booking
    slots_count_possible_per_day.floor.times.map do |n|
      (beginning_of_work_day + (n * duration.minutes)).to_datetime
    end
  end

  def beginning_of_work_day
    Time.new(2021, 02, 03, 9, 0, 0, 0)
  end
end
