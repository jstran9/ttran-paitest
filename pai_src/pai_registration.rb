require 'capybara'
require 'securerandom'
require 'capybara/poltergeist'
require_relative 'pai_base'

class PaiRegistration < PaiBase

  def initialize
    super
    @view_registration = "users/sign_up"
    @submit_registration = "users"
    @email_suffix = ".com"
    @number_of_random_characters = 4 # this is multiplied by 2 when generating the random characters.

    @first_name_key = "[first_name]"
    @first_name_field = "#{@user_prefix}#{@first_name_key}"

    @last_name_key = "[last_name]"
    @last_name_field = "#{@user_prefix}#{@last_name_key}"

    @phone_one_key = "phone1"
    @phone_two_key = "phone2"
    @phone_three_key = "phone3"

    @user_extension_key = "[extension]"
    @user_extension_field = "#{@user_prefix}#{@user_extension_key}"

    @password_confirmation_key = "[password_confirmation]"
    @password_confirmation_field = "#{@user_prefix}#{@password_confirmation_key}"

    # values.
    @first_name_value = "Todd"
    @last_name_value = "Tran"
    @invalid_user_password_two = "short1"
    @phone_one_value = "510"
    @phone_two_value = "766"
    @phone_three_value = "0650"
    @user_extension_value = "666"
    @expected_successful_registration_string = "Welcome back #{@first_name_value}"
  end

  # this method generates a random email address.
  # first a random string is generated then appended to an '@'
  # followed by another string then appended to '.com'.
  def generate_random_email_address
    random_email_account = SecureRandom.hex(@number_of_random_characters)
    random_domain_name = SecureRandom.hex(@number_of_random_characters)
    return random_email_account + "@" + random_domain_name + @email_suffix
  end

  # fill in the fields with specified values.
  # the reason why only these three fields are parameters are because we are interested in error checking
  # for these three fields.
  def fill_in_fields_and_submit(email, password, password_confirmation)
    @session.fill_in(@first_name_field, :with => @first_name_value)
    @session.fill_in(@last_name_field, :with => @last_name_value)
    @session.fill_in(@email_field, :with => email)
    @session.fill_in(@phone_one_key, :with => @phone_one_value)
    @session.fill_in(@phone_two_key, :with => @phone_two_value)
    @session.fill_in(@phone_three_key, :with => @phone_three_value)
    @session.fill_in(@user_extension_field, :with => @user_extension_value)
    @session.fill_in(@password_field, :with => password)
    @session.fill_in(@password_confirmation_field, :with => password_confirmation)
    @session.find(@form_submit_button_name).click
  end

  # this method simulates when the user enters valid fields except for the password and password
  # confirmation fields.
  def failed_registration_without_matching_passwords
    @session.visit(@pai_main_url + @view_registration)
    fill_in_fields_and_submit(generate_random_email_address, @user_password, @invalid_user_password)
    return parse_failure_message(find_div_with_fail_message)
  end

  # this simulates when the user has matching passwords but the email attempting to be registered
  # already been taken by another user.
  def failed_registration_with_email_already_taken
    @session.visit(@pai_main_url + @view_registration)
    fill_in_fields_and_submit(@user_email, @user_password, @user_password)
    return parse_failure_message(find_div_with_fail_message)
  end

  # this simulates when only the password field does not meet minimum requirements
  def failed_registration_with_incorrect_password_requirement
    @session.visit(@pai_main_url + @view_registration)
    fill_in_fields_and_submit(generate_random_email_address, @invalid_user_password, @invalid_user_password)
    return parse_failure_message(find_div_with_fail_message)
  end

  # this simulates when the us e enters a password that doesn't meet minimum requirements and an email that has
  # already been taken.
  def failed_registration_with_incorrect_password_requirement_and_in_use_email
    @session.visit(@pai_main_url + @view_registration)
    fill_in_fields_and_submit(@user_email, @invalid_user_password, @invalid_user_password)
    return parse_failure_message(find_div_with_fail_message)
  end

  def failed_registration_with_incorrect_password_requirement_non_matching_passwords_and_in_use_email
    @session.visit(@pai_main_url + @view_registration)
    fill_in_fields_and_submit(@user_email, @invalid_user_password, @invalid_user_password_two)
    return parse_failure_message(find_div_with_fail_message)
  end

  # this is if the user fills out all fields
  # we expect to see the user to be redirected to http://pai-test.herokuapp.com/?new and
  # more importantly we should see "Welcome back, username" and a "Logout" link.
  # we will also look for a success message of "Welcome! You have signed up successfully."
  def successful_registration
    @session.visit(@pai_main_url + @view_registration)
    fill_in_fields_and_submit(generate_random_email_address, @user_password, @user_password)
    return parse_message(find_div_with_success_message)
  end

  # this is what happens when the user succesfully registers and gets logged in.
  # on the right hand side instead of "Have an account? Log in" we instead expect to see
  # "Welcome back, Todd(first name)" followed by a Logout hyperlink (on the right).
  def successful_registration_look_for_right_hand_side_content
    @session.visit(@pai_main_url + @view_registration)
    fill_in_fields_and_submit(generate_random_email_address, @user_password, @user_password)
  end

  # helper method which looks for a div that contains Text of "Welcome Back, #{username}"
  # followed by a Logout hyperlink.
  # returns true if this content is on the web page, if not return false.
  def find_logged_in_content
    div_contents = @session.find('div.col-lg-3.col-md-3.col-sm-4.col-xs-4.text-right').text(false).split(" ")
    return parse_successful_registration_redirect(div_contents)
  end

  def find_logout_text
    div_contents = @session.find("div.sign-up.col-lg-2.col-md-2.col-sm-2.col-xs-2.text-center").text(false).split(" ")
    return parse_successful_registration_redirect(div_contents)
  end

  # finds the div tag with the message indicating the user failed to properly authenticate/logged in.
  def find_div_with_fail_message
     return @session.all('div.alert.alert-danger.alert-block ul li')
     # return @session.all('div.form-group.has-error span.help-block')
  end

  # grabs the error messages and puts them into a long growing string separted by endline characters for
  def parse_failure_message(output)
    output_message = ""
    output.each { |message| output_message += message.text + "\n"}
    return output_message.rstrip # strip off trailing end line character.
  end

  # this will grab the string as welcome back, username.
  # it will also grab the logout text.
  def parse_successful_registration_redirect(output)
    contents_parsed = ""
    output.each {|content| contents_parsed += content + " "}
    return contents_parsed.rstrip
  end
end