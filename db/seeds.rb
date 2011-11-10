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
SchedulePlan.delete_all
Workday.delete_all
VersionLog.delete_all



VersionLog.create! :table => "version", :version => 1

Specialty.create! :name => "Surgery"
Specialty.create! :name => "Oftalmology"

Doctor.create! :sex => "male", :specialty => Specialty.all.first, :photo => "http://www.gettyicons.com/free-icons/101/sigma-medical/png/256/doctor_256.png",  :user => User.create(:name => "Diogo", :birthdate => Date.new(1989, 01, 02), :username => "dcastro", :password => "1234")
Doctor.create! :sex => "male", :specialty => Specialty.all.second, :user => User.create(:name => "Fernando", :birthdate => Date.new(1989, 9,28), :username => "fern", :password => "1234")

Patient.create! :sex => "female", :address => "Rua que sobe e desce", :user => User.create(:name => "Sonia", :birthdate => Date.new(1989,4,26), :username => "sonia", :password => "123")

SchedulePlan.create! doctor: Doctor.first, active: true
SchedulePlan.create! doctor: Doctor.first, start_date: Date.new(2012,1,1)
SchedulePlan.create! doctor: Doctor.all.second, active: true

Workday.create! schedule_plan: SchedulePlan.first, weekday: 1, start: 480, end: 960 # segundas-feiras 8h -> 16h
Workday.create! schedule_plan: SchedulePlan.first, weekday: 2, start: 480, end: 960 # terças-feiras 8h -> 16h

Workday.create! schedule_plan: SchedulePlan.all.second, weekday: 3, start: 600, end: 1080 # quartas-feiras 10h -> 18h
Workday.create! schedule_plan: SchedulePlan.all.second, weekday: 4, start: 600, end: 780 # quintas-feiras 10h -> 13h

Workday.create! schedule_plan: SchedulePlan.all.third, weekday: 5, start: 840, end: 1020 # sextas-feiras 14h -> 17h



Appointment.create! patient: Patient.first, doctor: Doctor.first, scheduled_date: DateTime.new(2011, 12, 5, 10,30) #segunda

Appointment.create! patient: Patient.first, doctor: Doctor.first, scheduled_date: DateTime.new(2011, 12, 6, 10,30) #terça

Appointment.create! patient: Patient.first, doctor: Doctor.first, scheduled_date: DateTime.new(2012, 1, 11, 12,30) #quarta
Appointment.create! patient: Patient.first, doctor: Doctor.first, scheduled_date: DateTime.new(2012, 1, 12, 11,30) #quinta

Appointment.create! patient: Patient.first, doctor: Doctor.all.second, scheduled_date: DateTime.new(2011, 12, 16, 15,30) #quinta
