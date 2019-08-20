



def passed_by(param)
  puts param.object_id
end

a = 5.6

puts a.object_id

passed_by(a)