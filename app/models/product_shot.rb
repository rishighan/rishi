class ProductShot < ActiveRecord::Base

  belongs_to :product
  has_attached_file :shot, :styles => { :medium => "637x471>", 
                    :thumb => Proc.new { |instance| instance.resize }},
                    :url => "/shots/:style/:basename.:extension",
                    :path =>":rails_root/public/shots/:style/:basename.:extension"
                    
                    
  validates_attachment_content_type :shot, :content_type => ['image/png', 'image/jpg', 'image/jpeg', 'image/gif  ']                  
  validates_attachment_size :shot, :less_than => 2.megabytes


### End Paperclip ####

 def resize     
     geo = Paperclip::Geometry.from_file(shot.to_file(:original))

     ratio = geo.width/geo.height  

     min_width  = 142
     min_height = 119

     if ratio > 1
       # Horizontal Image
       final_height = min_height
       final_width  = final_height * ratio
       "#{final_width.round}x#{final_height.round}!"
     else
       # Vertical Image
       final_width  = min_width
       final_height = final_width * ratio
       "#{final_height.round}x#{final_width.round}!"
     end
  end 
  
  

    
end
