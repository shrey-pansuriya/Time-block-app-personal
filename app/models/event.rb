class Event < ApplicationRecord
    belongs_to :user
  
    enum priority: [:low, :medium, :high]
  
    validates :name, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
  end