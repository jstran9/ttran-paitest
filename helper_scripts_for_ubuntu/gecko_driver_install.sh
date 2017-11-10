# https://askubuntu.com/questions/870530/how-to-install-geckodriver-in-ubuntu
wget https://github.com/mozilla/geckodriver/releases/download/v0.18.0/geckodriver-v0.18.0-linux64.tar.gz

tar -xvzf geckodriver*

chmod +x geckodriver

sudo mv geckodriver /usr/local/bin/

rm *.gz # only one file will have the .gz so delete it.
