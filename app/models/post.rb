class Post < ActiveRecord::Base
validates :title, presence: true
validates :content, presence: true, length: {minimum: 250}
validates :summary, presence: true, length: {maximum: 250}
validates :category, presence: true, inclusion: {in: %w(Fiction Non-Fiction), message: "%{value} is not a valid category"}
validate :is_clickbait?

CLICKBAIT_PATTERNS = [
  /Won't Believe/i,
  /Secret/i,
  /Top [0-9]*/i,
  /Guess/i
]

def is_clickbait?
  if CLICKBAIT_PATTERNS.none? { |pattern| pattern.match title }
    errors.add(:title, "must be clickbait")
  end
end

end
