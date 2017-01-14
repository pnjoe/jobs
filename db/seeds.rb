# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "自动生成种子资料"

u = User.create([email:"guangdongjoe@gmail.com", password:"123456", password_confirmation:"123456",is_admin:"true"])

j = for i in 1..10 do
Job.create([title:"job no.#{i}", description:"这是seed建立的第#{i}个职作", wage_upper_bound: rand(50..90)*100, wage_lower_bound: rand(10..49)*100, contact_email:"#{i}#{'@'}21.cn", is_hidden:"false"])
end

puts "10个公开职缺已生成完毕"

j = for i in 1..10 do
Job.create([title:"job no.#{i+10}", description:"这是seed建立的第#{i+10}个职位", wage_upper_bound: rand(50..90)*100, wage_lower_bound: rand(10..49)*100, contact_email:"#{i}#{'@'}21.cn", is_hidden:"true"])
end

puts "10个隐藏职缺已生成完毕"
