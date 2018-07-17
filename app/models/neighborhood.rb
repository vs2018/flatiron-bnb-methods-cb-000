class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  has_many :reservations, through: :listings

  
  def self.highest_ratio_res_to_listings
    
    
    
    cities = Neighborhood.all
    
    highest_city = nil
    current_highest = 0
    
    cities.each do |city|
      
      listing_size = city.listings.size
      
      array_reservations = city.listings.map do |listing|
      listing.reservations.size
      end 
      
      total_reservations = array_reservations.sum
      
      if listing_size > 0 && total_reservations > 0
      
      complete = total_reservations / listing_size
      
      
      
      if complete > current_highest
        highest_city = city
        current_highest = complete
      end
      
      end
      
      

    end
    
    highest_city
    
  end
  
  
  def self.most_res
    cities = Neighborhood.all
    
    highest_city = nil
    current_highest = 0
    
    cities.each do |city|
      
      array_reservations = city.listings.map do |listing|
      listing.reservations.size
      end 
      
      total_reservations = array_reservations.sum
      
      if total_reservations > current_highest
        highest_city = city
        current_highest = total_reservations
      end
    

    end
    
    highest_city
  end

end
