module ContactsHelper
  def format_birthday(contact)
    if contact.birthday?
      contact.birthday.to_formatted_s(:birthday)
    else
      "Unknown"
    end
  end

  def format_name(contact)
    if contact.name?
      contact.name
    elsif contact.city?
      "Girl from #{contact.city}"
    else
      "Jane Doe"
    end
  end

  def children_list(contact)
    @contact.children.collect(&:to_s).join(", ")
  end
end
