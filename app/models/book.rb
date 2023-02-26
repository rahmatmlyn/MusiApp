class Book < ApplicationRecord
    validates :title, presence: true, length: {minimum:4}

    belongs_to :author
end
