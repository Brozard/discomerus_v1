class Picture < ActiveRecord::Base
  belongs_to :product

  has_attached_file :photo, path: ":rails_root/public/images/:id/:filename", url: ":id/:filename"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :photo, matches: [/png\Z/, /jpe?g\Z/]
end
