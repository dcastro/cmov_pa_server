# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Doctor.delete_all
Specialty.delete_all
User.delete_all
Patient.delete_all
VersionLog.delete_all

VersionLog.create :table => "version", :version => 1
#VersionLog.create :table => "SchedulePlan", :version => 1
#VersionLog.create :table => "Appointment", :version => 1

Specialty.create :name => "Surgery"
Specialty.create :name => "Oftalmology"


Doctor.create :sex => "male", :specialty => Specialty.all.first, :user => User.create(:name => "Diogo", :birthdate => Date.new(1989, 01, 02), :username => "dcastro", :password => "1234")
Doctor.create :sex => "male", :specialty => Specialty.all.second, :user => User.create(:name => "Fernando", :birthdate => Date.today, :username => "fern", :password => "1234")

Patient.create :sex => "female", :user => User.create(:name => "Sonia", :birthdate => Date.yesterday, :username => "sonia", :password => "123")

Appointment.create! :doctor => Doctor.first, :patient => Patient.first, :scheduled_date => DateTime.new(2011, 10, 8, 10, 30)
Appointment.create! doctor: Doctor.first, patient: Patient.first, scheduled_date: DateTime.new(2011, 10, 11, 11, 00)

Appointment.create! doctor: Doctor.first, patient: Patient.first, scheduled_date: DateTime.new(2011, 10, 29, 10, 0)
Appointment.create! doctor: Doctor.first, patient: Patient.first, scheduled_date: DateTime.new(2011, 11, 1, 10, 0)


