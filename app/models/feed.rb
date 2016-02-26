class Feed < ActiveRecord::Base
  # Remember to create a migration!
  validates :feedid, uniqueness: true



 # After initialization, set default values
  after_create :send_sms_alert


  private
  def distance loc1, loc2
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rm * c # Delta in meters
  end

  
  def send_sms_alert
      puts '*' * 100
      puts self.place
      puts '*' * 100

    @requests = Request.all
    @requests.each do |r|
      puts '*' * 100
      puts "Place: #{self.place}"
      puts "User Radius (km): #{r.radius / 1000}"
      puts "Dist to Epicenter: #{((distance [self.latitude, self.longtitude],[r.latitude, r.longtitude]) / 1000)}"
      if (r.radius / 1000) > ((distance [self.latitude, self.longtitude],[r.latitude, r.longtitude]) / 1000)
        account_sid = "AC89294858457a39db9344e500c34e0b26"
        auth_token = "e43a8b8db11d15f5029eb972b637df7d"
        client = Twilio::REST::Client.new account_sid, auth_token
       
        from = "+16505819607" # Your Twilio number     
        reciever = "+14158678407"

          client.account.messages.create(
            :from => from,
            :to => reciever,
            :body => "Earthquake alert! Magnitude: #{self.mag} Epicenter: #{self.place} - Time: #{self.time}"
          )        
        puts "User Alert: YESSSSS"
      else
        puts "User Alert: NOOOOOO"
      end
      puts '*' * 100
    end
    puts '=111=' * 100
  end
end