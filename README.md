Angular-Mail
=================

Angular-Mail is an fake email application based on GMail built with AngularJS.
It is a test to see what I can do with AngularJS and to get me up to speed on
building a full application.

Getting Setup
=============

Clone this repo where you want your project to live:

    git clone git@github.com:dansackett/angular-mail

Next make sure you install nodeJS:

    sudo apt-get install -y python-software-properties
    sudo add-apt-repository ppa:chris-lea/node.js
    sudo apt-get update
    sudo apt-get install nodejs

Next install Bower and Gulp (It's recommended to install it globally):

    sudo npm install -g bower gulp

Next install the gulp packages we'll use for this repo:

    sudo npm install

Next install bower components:

    bower install

Finally, type:

    gulp

If all was installed correctly, you will have a fully functional website setup
wherever your local server instance is located.
