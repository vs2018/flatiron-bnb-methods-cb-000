class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, :through => :listings

  
  def city_openings(start_date, end_date)
        listings.merge(Listing.available(start_date, end_date))

  end
  
  def self.highest_ratio_res_to_listings
    
    cities = City.all
    
    highest_city = nil
    current_highest = 0
    
    cities.each do |city|
      
      listing_size = city.listings.size
      
      array_reservations = city.listings.map do |listing|
      listing.reservations.size
      end 
      
      total_reservations = array_reservations.sum
      
      complete = total_reservations / listing_size
      
      if complete > current_highest
        highest_city = city
        current_highest = complete
      end
      
      

    end
    
    highest_city
    
  end
  
  
  def self.most_res
    cities = City.all
    
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

