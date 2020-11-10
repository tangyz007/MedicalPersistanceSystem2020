Given /the following questions exist/ do |questions_table|
  questions_table.hashes.each do |question|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    _patient = User.find_by_full_name(question['name'])
    _provider = User.find_by_full_name(question['provider_name'])
    question['patient_id'] = _patient.id
    question['user_id'] = _provider.id
    question.except!('provider_name')
    
    Question.create(question)
  end
  # fail "Unimplemented"
end