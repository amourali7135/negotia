require 'faker'

# Clear existing data
puts "Destroying everything..."
User.destroy_all
Conflict.destroy_all
Negotiation.destroy_all
Proposal.destroy_all
ProposalResponse.destroy_all
PracticeSession.destroy_all
Issue.destroy_all
IssueAnalysis.destroy_all
PracticeSessionOutcome.destroy_all

# Create users
puts "Creating users"
5.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    admin: [true, false].sample
  )
end

puts 'Creating 2 fake admin users...'
User.create!(email: 'amir@mourali.com', password: 'password', admin: true)
User.create!(email: 'amir@fake.com', password: 'password', admin: true)
puts 'Finished with the users!'

users = User.all

# Create conflicts
puts "Creating conflicts"
10.times do
  Conflict.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    problem: Faker::Lorem.paragraph(sentence_count: 2),
    status: Conflict.statuses.keys.sample,
    opponent: Faker::Name.name,
    priority: Conflict.priorities.keys.sample,
    objective: Faker::Lorem.sentence(word_count: 5),
    conflict_type: Conflict.conflict_types.keys.sample,
    user: users.sample
  )
end

conflicts = Conflict.all

# Create negotiations
puts "Creating negotiations"
15.times do
  user1, user2 = users.sample(2)
  next if user1 == user2

  conflict1 = conflicts.sample
  conflict2 = [conflicts.sample, nil].sample

  negotiation = Negotiation.create!(
    user1: user1,
    user2: user2,
    user2_email: user2.email,
    user2_name: user2.name,
    conflict1: conflict1,
    conflict2: conflict2,
    status: Negotiation.statuses.keys.sample
  )

  # Create proposals for each negotiation
  3.times do
    proposal = negotiation.proposals.create!(
      content: Faker::Lorem.paragraph,
      user: [user1, user2].sample
    )

    # Create proposal responses for each proposal
    2.times do
      proposal.proposal_responses.create!(
        status: ProposalResponse.statuses.keys.sample,
        comment: Faker::Lorem.sentence,
        user: [user1, user2].sample
      )
    end
  end

  # Create messages for each negotiation
  5.times do
    negotiation.messages.create!(
      content: Faker::Lorem.sentence(word_count: 10),
      user: [user1, user2].sample
    )
  end
end

# Create practice sessions
puts "Creating practice sessions"
20.times do
  user = users.sample
  conflict = conflicts.sample

  practice_session = PracticeSession.create!(
    conflict: conflict,
    user: user,
    status: PracticeSession.statuses.keys.sample
  )

  # Create issue analyses for each practice session
  3.times do
    issue = conflict.issues.sample || conflict.issues.create!(
      title: Faker::Lorem.sentence(word_count: 4),
      description: Faker::Lorem.paragraph
    )

    practice_session.issue_analyses.create!(
      issue: issue,
      alternative_solutions: Faker::Lorem.sentences(number: 2).join(' '),
      possible_solutions: Faker::Lorem.sentences(number: 2).join(' '),
      best_alternative: Faker::Lorem.sentence(word_count: 5),
      worst_alternative: Faker::Lorem.sentence(word_count: 5),
      desired_outcome: Faker::Lorem.sentence(word_count: 5),
      minimum_acceptable_outcome: Faker::Lorem.sentence(word_count: 5),
      ideal_outcome: Faker::Lorem.sentence(word_count: 5),
      expected_outcome: Faker::Lorem.sentence(word_count: 5),
      status: IssueAnalysis.statuses.keys.sample,
      importance: IssueAnalysis.importance.keys.sample,
      difficulty: IssueAnalysis.difficulty.keys.sample,
      satisfaction_level: IssueAnalysis.satisfaction_levels.keys.sample
    )
  end

  # Create practice session outcome for each practice session
  PracticeSessionOutcome.create!(
    practice_session: practice_session,
    overall_result: PracticeSessionOutcome.overall_results.keys.sample,
    status: PracticeSessionOutcome.statuses.keys.sample,
    satisfaction_level: rand(1..10),
    lessons_learned: Faker::Lorem.paragraph(sentence_count: 3),
    next_steps: Faker::Lorem.paragraph(sentence_count: 3)
  )
end

puts "Seeding completed!"