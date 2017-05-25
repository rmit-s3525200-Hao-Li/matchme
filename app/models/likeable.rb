class Likeable < ApplicationRecord
    
    # Set up associations
    belongs_to :liker, class_name: "User"  
    belongs_to :liked, class_name: "User"
    
    # Orders likeable objects by created_at
    default_scope -> { order('created_at DESC') }
    
    # Validation
    validates :liker_id, presence: true  
    validates :liked_id, presence: true
    
end
