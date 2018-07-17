class Listing < ActiveRecord::Base
  belongs_to :neighborhood, required: true
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  
        validates :address, presence: true
        validates :listing_type, presence: true
        validates :title, presence: true
        validates :description, presence: true
        validates :price, presence: true
        validates :neighborhood_id, presence: true
        
        before_save :enable_host
        
        
        before_destroy :disable_host
        
        def enable_host
          host.update(host: true) if host
        end
        
        def disable_host
          
          if  self.host.listings.count == 1
          host.update(host: false)
        end
        end
        
        
        
      # before_validation :change_host_status
      
      # def change_host_status
      #   self.user.host.status = true
      # end
      
      def average_review_rating
        count = 0.0
        total = 0.0 
        self.reviews.each_with_index do |review, index|
          count = index + 1
          total += review.rating
          
          
        end
        
        (total.to_f / count.to_f).to_f
        
      end
  
end
