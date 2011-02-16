class Subscriber < ActiveRecord::Base

  attr_protected :token
  
  scope :active, where("unsubscribed_at IS NULL").order("updated_at DESC")
  scope :unsubscribed, where("unsubscribed_at IS NOT NULL").order("unsubscribed_at DESC")
  
  validates :email, :email => true, :uniqueness => true
  
  before_create :set_token
  
  def active?
    unsubscribed_at.to_s.empty?
  end
  
  def resubscribe!
    return true if active?
    self.unsubscribed_at = nil
    save
  end
  
  def unsubscribe!
    return true unless active?
    self.unsubscribed_at = Time.now
    save
  end
  
  def email=(value)
    write_attribute :email, value.strip.downcase
  end
    
  private
  
    def set_token
      write_attribute :token, Digest::SHA1.hexdigest(Time.now.to_s)
    end
  
end
