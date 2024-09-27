require 'faker'

puts "Destroy everything..."
User.destroy_all
Conflict.destroy_all
Issue.destroy_all
Negotiation.destroy_all

puts 'Creating 2 fake users...'
user =
  User.new(
    email: 'amir@mourali.com',
    password: 'password',
    admin: false, 
  )
user.save!
user =
  User.new(
    email: 'amir@fake.com',
    password: 'password',
    admin: true, 
  )
user.save!
puts 'Finished with the users!'


puts "Creating 4 fake conflicts..."
2.times do 
conflict = Conflict.new(
  title: Faker::FunnyName, 
  problem: Faker::Quote, 
  status: "pending", 
  opponent: Faker::Nation, 
  priority: "high", 
  objective: Faker::University, 
  user_id: User.first
)
conflict.save!
end
2.times do 
  conflict = Conflict.new(
  title: Faker::FunnyName, 
  problem: Faker::Quote, 
  status: "in_progress", 
  opponent: Faker::Nation, 
  priority: "low", 
  objective: Faker::University, 
  user_id: User.second
  )
  conflict.save!
  end
puts "Finished creating conflicts!"

puts "Creating fake issues..."
3.times do 
  issue = Issue.new(
    title: Faker::University, 
    priority: "ordinary",
    compromise: Faker::Boolean, 
    explanation: Faker::Lorem, 
    ideal_outcome: Faker::Lorem, 
    acceptable_outcome: Faker::Lorem, 
    status: "pending", 
    conflict_id: Conflict.first
  )
  issue.save!
end
  3.times do 
    issue = Issue.new(
      title: Faker::University, 
      priority: "high",
      compromise: Faker::Boolean, 
      explanation: Faker::Lorem, 
      ideal_outcome: Faker::Lorem, 
      acceptable_outcome: Faker::Lorem, 
      status: "pending", 
      conflict_id: Conflict.second
    )
    issue.save!
  end
    3.times do 
      issue = Issue.new(
        title: Faker::University, 
        priority: "very_high",
        compromise: Faker::Boolean, 
        explanation: Faker::Lorem, 
        ideal_outcome: Faker::Lorem, 
        acceptable_outcome: Faker::Lorem, 
        status: "pending", 
        conflict_id: Conflict.third
      )
      issue.save!
    end
      3.times do 
        issue = Issue.new(
          title: Faker::University, 
          priority: "ordinary",
          compromise: Faker::Boolean, 
          explanation: Faker::Lorem, 
          ideal_outcome: Faker::Lorem, 
          acceptable_outcome: Faker::Lorem, 
          status: "pending", 
          conflict_id: Conflict.fourth
        )
        issue.save!
      end




puts "Creating fake negotations..."
negotiation = Negotiation.new(
  status: , 

 )
