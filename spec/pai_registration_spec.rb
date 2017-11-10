require_relative "../pai_src/pai_registration"

describe "failed registration where password fields don't match." do
	paiRegistrationTest = PaiRegistration.new
	it "Returns the message, 'Password confirmation doesn't match Password'" do
		expect(paiRegistrationTest.failed_registration_without_matching_passwords).to eq("Password confirmation doesn't match Password")
	end
end


describe "failed registration because email address is already in use." do
	paiRegistrationTest = PaiRegistration.new
	it "Returns the message twice (on two separate lines), 'Email has already been taken'" do
		expect(paiRegistrationTest.failed_registration_with_email_already_taken).to eq("Email has already been taken\nEmail has already been taken")
	end
end


describe "failed registration because the password does not meet minimum requirements." do
	paiRegistrationTest = PaiRegistration.new
	it "Returns the message, 'Password is too short (minimum is 8 characters)'" do
		expect(paiRegistrationTest.failed_registration_with_incorrect_password_requirement).to eq("Password is too short (minimum is 8 characters)")
	end
end


describe "failed registration because the password requirement isn't met and the email has been taken." do
	paiRegistrationTest = PaiRegistration.new
	it "Returns the message, 'Email has already been taken' on two separate lines, and 'Password confirmation doesn't match Password' followed by that on a separate line." do
		expect(paiRegistrationTest.failed_registration_with_incorrect_password_requirement_and_in_use_email).to eq("Email has already been taken\nEmail has already been taken\nPassword is too short (minimum is 8 characters)")
	end
end


describe "failed registration because the password requirement isn't met, the passwords don't match, and the email is already in use." do
	paiRegistrationTest = PaiRegistration.new
	it "Returns the message, 'Password confirmation doesn't match Password'" do
		expect(paiRegistrationTest.failed_registration_with_incorrect_password_requirement_non_matching_passwords_and_in_use_email).to eq("Email has already been taken\nEmail has already been taken\nPassword confirmation doesn't match Password\nPassword is too short (minimum is 8 characters)")
	end
end


describe "the successful registration." do
	paiRegistrationTest = PaiRegistration.new
	it "Returns the text, 'Welcome! You have signed up successfully.'" do
		expect(paiRegistrationTest.successful_registration).to eq("Welcome! You have signed up successfully.")
	end
end


describe "the successful registration looks for specific divs with a welcome message to the user's first name and a logout text." do
  paiRegistrationTest = PaiRegistration.new
	paiRegistrationTest.successful_registration_look_for_right_hand_side_content
	it "Returns the text, 'Welcome back, Todd'" do
    expect(paiRegistrationTest.find_logged_in_content).to eq("Welcome back, Todd")
  end
  it "Returns the text, 'Logout'" do
		expect(paiRegistrationTest.find_logout_text).to eq("Logout")
  end
end