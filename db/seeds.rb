# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
	name: 'admin',
	email: 'admin@covenant.edu',
	password: 'adminadmin',
	role: 'admin',
	confirmed_at: Time.now
).save!

User.create(
	name: 'teacher',
	email: 'teacher@covenant.edu',
	password: 'teacherteacher',
	role: 'teacher',
	confirmed_at: Time.now
).save!

User.create(name: 'student',
	email: 'student@covenant.edu',
	password: 'studentstudent',
	role: 'student',
	enrollment_time: 2015,
	graduation_time: 2019,
	banner_id: '01157703',
	confirmed_at: Time.now
).save!

student = User.find_by_name("student")
teacher = User.find_by_name("teacher")
cos_major = Major.find_by_name("COS")
cos_minor = Minor.find_by_name("COS")
cyber_security = Concentration.find_by_name("Cyber Defense")
software_development = Concentration.find_by_name("Software Development")

UsersMajor.create(user_id: student.id, major_id: cos_major.id)
UsersMajor.create(user_id: teacher.id, major_id: cos_major.id)
UsersMinor.create(user_id: student.id, minor_id: cos_minor.id)
UsersMinor.create(user_id: teacher.id, minor_id: cos_minor.id)
UsersConcentration.create(user_id: student.id, concentration_id: cyber_security.id)
UsersConcentration.create(user_id: teacher.id, concentration_id: cyber_security.id)
UsersConcentration.create(user_id: student.id, concentration_id: software_development.id)
UsersConcentration.create(user_id: teacher.id, concentration_id: software_development.id)