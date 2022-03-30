class Message < ApplicationRecord
  belongs_to :inbox
  belongs_to :user

  MIN_NAME = 5
  MAX_NAME = 2000

  validates :body, presence: true
  # validates :body, uniqueness:{scope: :inbox_id}
  validates :body, length: { in: MIN_NAME..MAX_NAME }
end