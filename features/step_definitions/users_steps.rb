Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    puts user
    User.create(user)
    
    User.all().each do |u|
      puts u.id
    end
  end
  # fail "Unimplemented"
end