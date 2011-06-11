# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require 'factory_girl'
Dir[Rails.root + "factories/*.rb"].each do |file|
require file
end

admin_user = Factory(:user, :email => "admin@ticketee.com")
admin_user.admin = true
admin_user.confirm!

Factory(:project, :name => "Ticketee Beta")

State.create( :name => "New",
              :background => "#85FF00",
              :color => "white")

State.create( :name => "Open",
              :background => "#00CFFD",
              :color => "white")

State.create( :name => "Closed",
              :background => "black",
              :color => "white")
