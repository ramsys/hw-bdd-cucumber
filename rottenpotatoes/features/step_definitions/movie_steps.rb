# Add a declarative step here for populating the DB with movies.
# require File.expand_path(File.join(File.dirname(__FILE__), ".", "web_steps"))

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(title: movie[:title], rating: movie[:rating], relase_date: movie[:release_date])
  end
  # fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  #fail "Unimplemented"
  rating_list.split(',').each do |rating|
    if uncheck
      step %Q{I uncheck "ratings_#{rating.strip}"}
    else
      step %Q{I check "ratings_#{rating.strip}"}
    end
  end
end

Given /I only check the following ratings: (.*)/ do |rating_list|
  Movie.all_ratings.each do |rating|
    if rating_list.include? rating
      step %Q{I check "ratings_#{rating}"}
    else
      step %Q{I uncheck "ratings_#{rating}"}
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  # fail "Unimplemented"
  # find(:xpath, '//table[@id = "movies"]/tbody/tr').all.rows.should == 10
  # find('#movies/tbody/tr')
  expect(page).to have_css('#movies/tbody/tr', count: 10)
end
