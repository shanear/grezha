module ContactsHelper
  def contact_picture_tag(contact, size = :medium)
    image_tag(contact.picture.exists? ? contact.picture.url(size) : "no_picture_#{size}.png")
  end
end
