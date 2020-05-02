
Given /the following requests exist/ do |request_table|
    request_table.hashes.each do |request|
      Request.create request
    end
  end