require 'yaml'

class PaiBase
  def initialize

    set_capybara_driver
	
    @pai_main_url = "http://pai-test.herokuapp.com/"
    @logout_text = "Logout"
    @form_submit_button_name = "[name=commit]"

    @user_prefix = "user"
    @email_key = "[email]"
    @email_field = "#{@user_prefix}#{@email_key}"

    @password_key = "[password]"
    @password_field = "#{@user_prefix}#{@password_key}"

    # values.
    @yahoo_domain = "@yahoo.com"
    @email_name = "ww1fox"

    @user_password = "validone"
    @invalid_user_password = "short"
    @user_email = "#{@email_name}#{@yahoo_domain}"
  end

  # grab the message and return it as a string stripping off the ending white space.
  def parse_message(output)
    contents_parsed = ""
    output.drop(1).each {|content| contents_parsed += content + " "}
    return contents_parsed.rstrip
  end

  # finds the div tag with the message to display the log in and log out status.
  def find_div_with_success_message
    if @driver_value == 1
      return @session.find('div.alert.alert-success.alert-dismissable').text(false).split("\u00D7")
    end
    return @session.find('div.alert.alert-success.alert-dismissable').text(false).split(" ")
  end

  def set_capybara_driver
    begin
	  config = YAML.load_file("config/capybara_driver_config.yml")
      if config["driver"].nil? then @driver_value = 1 end
    rescue Errno::ENOENT
      @driver_value = 1
    end

    if @driver_value != 1 then @driver_value = config["driver"].to_i end

    if @driver_value == 2
      @session = Capybara::Session.new(:selenium)
    elsif @driver_value == 3
      @session = Capybara::Session.new(:selenium_chrome)
    else
      @driver_value = 1
      # this will ignore any js errors on the web page.
      # without this there is a compilation error and this class cannot navigate the web pages.
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, {:js_errors => false})
      end

      @session = Capybara::Session.new(:poltergeist)
    end
  end
end
