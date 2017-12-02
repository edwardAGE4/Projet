class Town < ActiveRecord::Base
  
  before_validation :load_position
  validates :lat, presence: true
  validates :lon, presence: true
  
  private
  def load_position
    places = Nominatim.search(name).limit(1).first
    if places
      self.lat = places.lat
      self.lon = places.lon
    end
  end
  
  public 
  def load_meteo
    ForecastIO.configure do |c|
       c.api_key ='b5e8c61582015cb588b780a7a1c5ec13'
    end
    ForecastIO.forecast(self.lat,self.lon)
  end
    
end