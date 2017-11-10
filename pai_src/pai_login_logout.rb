require 'capybara'
require 'capybara/poltergeist'
require_relative 'pai_base'

# I am not separating the login and logout into two classes because the logout is dependent on the login to properly
# work which would require the same session to be more efficient instead of logging in again then logging out via
# another session.
class PaiLoginLogout < PaiBase

  def initialize
    super
    @sign_in_path = "users/sign_in"
    @sign_out_path = "users/sign_out"

    @invalid_user_email = "fffffffffffffffffffffff@gmail.com"
    @invalid_not_email = "idonotexistok"
  end

  # this method performs a successful log in then log out.
  def login
    @session.visit(@pai_main_url + @sign_in_path)
    @session.fill_in(@email_field, :with => @user_email)
    @session.fill_in(@password_field, :with => @user_password)
    @session.find(@form_submit_button_name).click
    return parse_message(find_div_with_success_message)
  end

  # logging out when logged in.
  def logout
    @session.click_link(@logout_text)
    return parse_message(find_div_with_success_message)
  end

  # logging out without being logged in.
  def failed_logout
    @session.visit(@pai_main_url + @sign_out_path)
    return parse_message(find_div_with_fail_message)
  end

  # logging in with an existing user name but the wrong password.
  def login_with_wrong_password
    @session.visit(@pai_main_url + @sign_in_path)
    @session.fill_in(@email_field, :with => @user_email)
    @session.fill_in(@password_field, :with => @invalid_user_password)
    @session.find(@form_submit_button_name).click
    return parse_message(find_div_with_fail_message)
  end

  # logging in with a user email that doesn't exist.
  def login_with_non_existant_user
    @session.visit(@pai_main_url + @sign_in_path)
    @session.fill_in(@email_field, :with => @invalid_user_email)
    @session.fill_in(@password_field, :with => @invalid_user_password)
    @session.find(@form_submit_button_name).click
    return parse_message(find_div_with_fail_message)
  end

  # finds the div tag with the message indicating the user failed to properly authenticate/logged in.
  def find_div_with_fail_message
    if @driver_value == 1
      return @session.find('div.alert.alert-danger.alert-dismissable').text(false).split("\u00D7")
    end
    return @session.find('div.alert.alert-danger.alert-dismissable').text(false).split(" ")
  end
end