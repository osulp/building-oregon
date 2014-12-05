def capybara_login(user)
  visit new_user_session_path
  fill_in "Email", :with => user.email
  fill_in "Password", :with => user.password
  click_button "Sign in"
  expect(current_path).to eq root_path
end
