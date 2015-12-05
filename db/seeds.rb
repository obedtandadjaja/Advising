# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'linda', email: 'linda@test.com', password: 'notthereyo')
User.create(name: 'lee', email: 'lee@test.com', password: 'helloworld')

UsersCourse.create(user_id: 1, course_id: 18, taken_planned: '2015f', taken_on: '2015-09-27')
UsersCourse.create(user_id: 1, course_id: 19, taken_planned: '2015s', taken_on: '2015-03-13')
UsersCourse.create(user_id: 1, course_id: 21, taken_planned: '2016s')
UsersCourse.create(user_id: 1, course_id: 23, taken_planned: '2015f')
UsersCourse.create(user_id: 1, course_id: 270, taken_planned: '2017f')
UsersCourse.create(user_id: 1, course_id: 271, taken_planned: '2017f')
UsersCourse.create(user_id: 1, course_id: 273)

UsersMajor.create(user_id: 1, major_id: 1)
UsersMajor.create(user_id: 1, major_id: 2)

MajorsCourse.create(major_id: 1, course_id: 18)
MajorsCourse.create(major_id: 1, course_id: 19)
MajorsCourse.create(major_id: 1, course_id: 20)
MajorsCourse.create(major_id: 1, course_id: 21)
MajorsCourse.create(major_id: 1, course_id: 23)
MajorsCourse.create(major_id: 1, course_id: 100)

MajorsCourse.create(major_id: 2, course_id: 270)
MajorsCourse.create(major_id: 2, course_id: 271)
MajorsCourse.create(major_id: 1, course_id: 273)
MajorsCourse.create(major_id: 2, course_id: 500)

Major.create(name: "Art", total_hours: 120)
Major.create(name: "Computer Science", total_hours: 120)

Distribution.create(title: "Humanities")
Distribution.create(title: "Fine Arts")
DistributionsCourse.create(distribution_id: 2, course_id: 21)




