class Writing < ApplicationRecord
    # Associations
    belongs_to :user
    has_many :comments

    #Validations
    validates :title, presence: true
    validates :content, presence: true
    validates :genre, presence: true
    validates :category, presence: true

    # Scopes
end
