class Attachment < ActiveRecord::Base
  
  belongs_to :post
  
  #TODO: revisit different sizes for images.
  has_attached_file :photo, 
                    :styles =>{
                    :medium => "660x", 
                    :thumb => Proc.new { |instance| instance.resize }
                    },
                    :url => "/pictures/:style/:basename.:extension",
                    :path =>":rails_root/public/pictures/:style/:basename.:extension"
  before_post_process :resize_images       
                    
  #validates_attachment_content_type :photo, :content_type => ['image/png', 'image/jpg', 'image/jpeg', 'image/gif', 'image/tiff']                  
  validates_attachment_size :photo, :less_than => 2.megabytes         

    # check if asset is image
    # for use in the view
    def image?
      photo_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
    end
    
    
    def resize_images
      return false unless image?
    end
    
   def resize     
       geo = Paperclip::Geometry.from_file(photo.to_file(:original))

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
