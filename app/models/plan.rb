class Plan < ApplicationRecord
  belongs_to :user

  validates :date, presence: true
  validates :plan, inclusion: {in: [true, false]}
end
