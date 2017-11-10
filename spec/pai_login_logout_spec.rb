require_relative "../pai_src/pai_login_logout"

describe "the successful login and logout." do
	paiLoginTest = PaiLoginLogout.new
	it "Prints back two messages. 'Signed in successfully.' and 'Signed out successfully.'" do
		expect(paiLoginTest.login).to eq("Signed in successfully.")
		expect(paiLoginTest.logout).to eq("Signed out successfully.")
	end
end


describe "failed logout because user isn't logged in." do
	paiLoginTest = PaiLoginLogout.new
	it "Returns the message, 'You need to sign in or sign up before continuing.'" do
    expect(paiLoginTest.failed_logout).to eq("You need to sign in or sign up before continuing.")
	end
end


describe "failed login with incorrect password but valid email." do
  paiLoginTest = PaiLoginLogout.new
  it "Returns the message, 'Invalid Email or password.'" do
    expect(paiLoginTest.login_with_wrong_password).to eq("Invalid Email or password.")
  end
end


describe "failed login with email account that hasn't been created." do
	paiLoginTest = PaiLoginLogout.new
	it "Returns the message, 'Invalid Email or password.'" do
		expect(paiLoginTest.login_with_non_existant_user).to eq("Invalid Email or password.")
	end
end