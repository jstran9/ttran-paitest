# https://gist.github.com/maciekkolodziej/b383c0b956b4f89c6f19a358a468237b

# Remove existing downloads and binaries so we can start from scratch.
sudo rm /usr/local/bin/chromedriver
sudo rm /usr/local/share/chromedriver

# Install dependencies.
sudo apt-get update
sudo apt-get install -y openjdk-8-jre-headless xvfb libxi6 libgconf-2-4

# Install ChromeDriver.
wget -N http://chromedriver.storage.googleapis.com/2.27/chromedriver_linux64.zip -P ~/
unzip ~/chromedriver_linux64.zip -d ~/
rm ~/chromedriver_linux64.zip
sudo mv -f ~/chromedriver /usr/local/share/
sudo chmod +x /usr/local/share/chromedriver
sudo ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
