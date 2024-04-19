class Event < ApplicationRecord
    belongs_to :user
    class Event < ApplicationRecord
        validates :name, presence: true
        validates :start_time, presence: true
        validates :end_time, presence: true
    end
end
