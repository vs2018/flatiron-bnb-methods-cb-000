class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review
   validates :checkin, presence: true
      validates :checkout, presence: true
      
      validates :checkin, uniqueness: true
      
      validates :listing, presence: true
      validate :checking_before_checkout
      
      validate :checkin_checkout_date_not_same
      
      validate :listing_available_at_checkin
      
      validate :guest_and_host_not_the_same
      
      
       def guest_and_host_not_the_same
    if self.guest_id == self.listing.host_id
      errors.add(:guest_id, "You can't book your own apartment")
    end
  end
      
      
      def listing_available_at_checkin
       
        self.listing.reservations.each do |reservation|
          if self.checkin
          if reservation.checkin <= self.checkin && reservation.checkout >= self.checkout 
             errors.add(:base, "cant reserve")

            end
          end
        end
      end
      
      
      
      def checkin_checkout_date_not_same
        if self.checkin
        if self.checkout 
            if self.checkin == self.checkout
          errors.add(:checkout, "cant be same")
        end
      end 
    end
      end
      
      def duration
        self.checkout - self.checkin
      end
      
      def total_price 
        duration * self.listing.price
      end
      
      

    # validate :cant_make_reservation_on_own_listing
    
    
    # def cant_make_reservation_on_own_listing
    #   if self.listing.id 
    # end
    
    def checking_before_checkout
      if self.checkin
        if self.checkout 
            if self.checkin > self.checkout
          errors.add(:checkout, "checkin has to be before checkout")
        end
      end 
    end
  end
end
