class Event < ApplicationRecord
    belongs_to :user
  
    enum priority: { low: 0, medium: 1, high: 2 }
  
    validates :name, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
  end
  