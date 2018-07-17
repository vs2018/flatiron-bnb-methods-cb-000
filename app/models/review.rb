class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"
  
   validates :rating, presence: true
   
        validates :description, presence: true
       
validates :reservation_id, presence: true

validate :reservation_accepted_and_checkout_happened

def reservation_accepted_and_checkout_happened
  if self.reservation
  if self.reservation.status == "pending" || self.reservation.checkout > Date.today
     errors.add(:reservation_id, "reservation has to be accepted and checked out")
   end
 end
end
end
