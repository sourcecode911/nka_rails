# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Invoice.delete_all
User.delete_all
Meter.delete_all
Count.delete_all
Flat.delete_all
InvoiceDetail.delete_all
Resident.delete_all


user1 = User.create(username: 'Cedric Oswald', email: 'cedric@oswaldonline.info', password: 'admin0815')
user2 = User.create(username: 'Sabine Oswald', email: 'sabine@oswaldonline.de', password: 'vds12%z6z/&hn!')
user3 = User.create(username: 'Karin Al Roubaiey', email: 'karin@test.de', password: 'karin_test')

flat1 = Flat.create(name: 'Wohnung 1', user_id: user1.id, area: 50, tax: 19, ownership: 50)
flat2 = Flat.create(name: 'Wohnung 2', user_id: user1.id, area: 50, tax: 19, ownership: 50)

Meter.create(name: 'KW1', flat_id: flat1.id, user_id: user1.id, expense_type: 0, initial_count: 0)
Meter.create(name: 'WW1', flat_id: flat1.id, user_id: user1.id, expense_type: 1, initial_count: 0)
Meter.create(name: 'H1', flat_id: flat1.id, user_id: user1.id, expense_type: 2, initial_count: 0)
Meter.create(name: 'S1', flat_id: flat1.id, user_id: user1.id, expense_type: 3, initial_count: 0)
Meter.create(name: 'WWG1', flat_id: flat1.id, user_id: user1.id, expense_type: 5, initial_count: 0)

Meter.create(name: 'KW2', flat_id: flat2.id, user_id: user1.id, expense_type: 0, initial_count: 0)
Meter.create(name: 'WW2', flat_id: flat2.id, user_id: user1.id, expense_type: 1, initial_count: 0)
Meter.create(name: 'H2', flat_id: flat2.id, user_id: user1.id, expense_type: 2, initial_count: 0)
Meter.create(name: 'S2', flat_id: flat2.id, user_id: user1.id, expense_type: 3, initial_count: 0)
Meter.create(name: 'WWG2', flat_id: flat2.id, user_id: user1.id, expense_type: 5, initial_count: 0)

Resident.create(first_name: 'Max', last_name: 'Mustermann', street: 'Adenauerstraße 36', plz: 66399, location: 'Mandelbachtal', email: 'max@mustermann.de', persons: 5, user_id: user1.id, flat_id: flat1.id, move_in: Date.new(1993, 6, 6))
Resident.create(first_name: 'Fritz', last_name: 'Fischer', street: 'Adenauerstraße 36', plz: 66399, location: 'Mandelbachtal', email: 'max@mustermann.de', persons: 3, user_id: user1.id, flat_id: flat2.id, move_in: Date.new(2016, 1, 1))
Resident.create(first_name: 'Manny', last_name: 'Müller', street: 'Adenauerstraße 36', plz: 66399, location: 'Mandelbachtal', email: 'max@mustermann.de', persons: 3, user_id: user1.id, flat_id: flat2.id, move_in: Date.new(2016, 6, 6))

invoice = Invoice.create(year: 2016, user_id: user1.id, erdgas: 200, kamin: 200, wartung: 200, reinigung: 200, gesamt_strom: 200, wasser: 1000, abwasser: 1000, niederschlag: 100, abfall: 1000, grundsteuer: 100, versicherung: 100)
user1.current_invoice_id = invoice.id
user1.save