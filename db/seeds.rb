# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Specialty.create :name => "Surgery"
Specialty.create :name => "Oftalmology"


Doctor.create :name => 'Diogo', :birthdate => Date.new(1989, 01, 02), :specialty => Specialty.all.first
Doctor.create :name => 'Fernando', :birthdate => Date.today, :specialty =>  Specialty.all.second


