class GeneratePeopleFromRelationships < ActiveRecord::Migration
  def up
    Relationship.where(person_id: nil).each do |relationship|
      person = Person.where(name: relationship.name).first

      person ||= Person.create!(
        organization_id: relationship.organization_id,
        name: relationship.name,
        role: relationship.relationship_type,
        contact_info: relationship.contact_info,
        notes: relationship.notes
      )

      relationship.update_attributes!(person: person)
    end
  end

  def down
    Person.delete_all
    Relationship.update_all("person_id = NULL")
  end
end
