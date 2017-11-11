## Background ##
- I decided to use Poltergeist and Capybara as I did not want a Browser popping up while running my tests then closing the browsers.
- If preferred we can also test using the Selenium Driver which uses Firefox or we can also test using Selenium Chrome which allows us to test on Chrome.
	- To do this go to the capybara_driver_config.yml and change the value accordingly.
- Extra Notes/Assumptions:
    - If you are looking to test with Firefox or Chrome I assume you have those browsers installed.
- If you have the following installed at each step feel free instructions in the step.

## Running on Ubuntu 16.04 LTS ##
- The commands at each step below assume you are working from the root directory.

1. Open a terminal and Install Ruby
    - sudo apt install ruby

2. Install Bundler.
    - sudo apt install ruby-bundler

3. Install Rspec
    - sudo apt install ruby-rspec-core

4. Install necessary libraries for Nokogiri
    - sudo apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev

5. Install PhantomJS, by running the .sh file I have provided (this is necessary for Poltergeist)
    - commands are:
    	- chmod +x helper_scripts_for_ubuntu/phantom_js_install.sh
	    - helper_scripts_for_ubuntu/phantom_js_install.sh
	- you can verify the installation by running "phantomjs --version"

6. Install the chrome driver (necessary if you choose to run the selenium_chromedriver)
    - commands are:
    	- chmod +x helper_scripts_for_ubuntu/chrome_driver_install.sh 
    	- helper_scripts_for_ubuntu/chrome_driver_install.sh

7. Install the gecko driver (necessary to test with firefox)
    - commands are:
    	- chmod +x helper_scripts_for_ubuntu/gecko_driver_install.sh
    	- helper_scripts_for_ubuntu/gecko_driver_install.sh

8. Use bundler to get other necessary gems
    - bundle install
    - make sure you run the command from step 4 or else the nokogiri gem will not install properly

9. Now just run all the tests
    - rspec
    
## Running on Windows 7 64 bit ##    

1. Download the RubyInstaller and install Ruby
	- go to https://rubyinstaller.org/downloads/ and download ruby 2.3.3 (x64) 
	- when walking through the installation make sure to check the option of "Add Ruby executables to your PATH"
	
2. Open a command prompt and install bundler	
    - gem install bundler

3. Install Rspec
    - gem install rspec
 
4. Install the necessary devkit and websocket-driver
    - https://rubyinstaller.org/downloads/
        - Download the DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe file.
    - Create a folder inside of C:\ called "devkit" and extract it there
        - Now cd to C:\devkit
            - Run ruby dk.rb init
            - Open config.yml and add "- C:\Ruby23-x64" (don't forget the hyphen!) to the bottom of the file.
            - Run ruby dk.rb install
    - gem install websocket-driver -v '0.7.0'
        
5. Install PhantomJS and add it to your PATH. (to test with Poltergeist)    
    - Go here http://phantomjs.org/download.html and download phantomjs-2.1.1-windows.zip. 
    - Extract it to a directory somewhere, i.e.: into C:, resulting in, C:\phantomjs-2.1.1-windows
    - Now use the following command to it to the your system path
		-setx path "%path%;C:\phantomjs-2.1.1-windows\bin"
    - verify that it is working with the below command
        - phantomjs
            - you should see "phantomjs> "
 
6. Install ChromeDriver and add it to your path (to test with Chrome)
    - Go here https://sites.google.com/a/chromium.org/chromedriver/downloads and download the latest release
    - Download the 32bit version for windows
    - Extract to C:\chromedriver_win32
    - Set this directory to your system path
        - setx path "%path%;C:\chromedriver_win32"
        
7. Install GeckoDriver and add it to your path (to test with Firefox)
    - Go here https://github.com/mozilla/geckodriver/releases and download geckodriver-v0.19.1-win64.zip
    - Extract it to C:\geckodriver-v0.19.1-win64
    - Set this directory to your system path
        - setx path "%path%;C:\geckodriver-v0.19.1-win64"
            
8. Run Bundler 
    - bundle install

9. Run the tests
    - rspec
    
    
## RUN ON MAC OS Sierra ##     

1. Install Curl
    - https://curl.haxx.se/download.html

2. Install Homebrew
    - https://brew.sh/
    - open a terminal and paste in the below command.
        - /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    - I will be using Brew as the package manager so make sure to have it to follow the steps below    

3. Install gpg2
    - brew install gpg2

4. Install RVM (to help with changing active ruby version)
    - gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    - \curl -sSL https://get.rvm.io | bash -s stable
 
5. Install ruby 2.3 and switch to it
    - rvm install ruby-2.3.0
    
6. Install Bundler
    - gem install bundler    

7. Install rspec.
    - gem install rspec

8. Install xcode-command line dev tools
    - xcode-select --install
        - then click the install button.
       
9. Install PhantomJS
    - brew install phantomjs

10. Install ChromeDriver
    - brew install chromedriver

11. Install GeckoDriver
    - brew install geckodriver

12. Run Bundler
    - bundle install

13. Run the tests    
    - rspec
