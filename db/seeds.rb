# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Invoice.delete_all
User.delete_all
User.create(username: 'Cedric Oswald', email: 'cedric@oswaldonline.info', password: 'admin0815')
User.create(username: 'Sabine Oswald', email: 'sabine@oswaldonline.de', password: 'vds12%z6z/&hn!')
