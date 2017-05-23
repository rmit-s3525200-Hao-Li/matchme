class Likeable < ApplicationRecord
    
    belongs_to :liker, class_name: "User"  
    belongs_to :liked, class_name: "User"
    
    default_scope -> { order('created_at DESC') }
    
    validates :liker_id, presence: true  
    validates :liked_id, presence: true
    
end
