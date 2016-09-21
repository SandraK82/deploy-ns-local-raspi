__Tested with:__ 

- Raspberry Pi 3

__Brief:__

Use this script to setup a complete local runnign nightscout instance with a local mongoDB instance

__Usage:__

`curl -s https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/ns-local-install.sh | bash -`

after running the script you will have a running nightscout local installation and an open editor with your config for nightscout. You need to configure at least the last line in the file:
API_SECRET=[MEIN PASSWORT]
And put an at least 12 characters long Passwort there!
Please note that you _CAN_NOT_ have any spaces in your configuration. To separate values use %20 instead. For the CUSTOM_TITLE Parameter this does not work! 

__With help from:__

https://c-ville.gitbooks.io/test/content/

http://yannickloriot.com/2016/04/install-mongodb-and-node-js-on-a-raspberry-pi/