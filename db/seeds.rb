organization = Organization.create(
  name: "Kool Klub"
)

User.create(
  name: "Admin",
  email: "admin@admin.com",
  password: "password",
  organization_id: organization.id
  role: "admin"
)

