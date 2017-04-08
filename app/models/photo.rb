class Photo < ApplicationRecord

  has_attached_file :image, styles: { medium: "800x800>", thumb: "250x250>" }, default_url: "/images/:style/missing.png"
  validates :image, attachment_presence: true
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  belongs_to :user

end
