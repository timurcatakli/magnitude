class User < ActiveRecord::Base
  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password_plaintext)
    @password = BCrypt::Password.create(new_password_plaintext)
    self.password_hash = @password.to_s
  end

  def authenticate(password_plaintext)
    return self.password == password_plaintext
  end


  # After initialization, set default values
  after_initialize :send_sms_verification

  private
  def send_sms_verification
    alphabet = %w[a b c d e f g h j k l m n o p q r s t u v y z x w]
    code = alphabet.sample.upcase + rand(1000..9999).to_s + alphabet.sample.upcase
    # Only set if time_zone IS NOT set
    self.sms_verification ||= code

# puts '*' * 50
# puts code
# puts '*' * 50

      account_sid = "AC89294858457a39db9344e500c34e0b26"
      auth_token = "e43a8b8db11d15f5029eb972b637df7d"
      client = Twilio::REST::Client.new account_sid, auth_token
     
      from = "+16505819607" # Your Twilio number     
      reciever = "+14158678407"

        client.account.messages.create(
          :from => from,
          :to => reciever,
          :body => "Here is your verification code: #{code}"
        )        
    end

end



