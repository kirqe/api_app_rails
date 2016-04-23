class Product < ActiveRecord::Base
  validates :title, :user_id, presens: true
  validates :price, numericality: { greater_than_or_equal_to: 0 },
                    presence: true
end
