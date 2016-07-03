# contro
FS20 home automation web based controller is a naiv approach to home automation using FS20 power sockets. 
The web application uses a python cgi to switch the devices. The web gui is used to control timings on devices. 
The application is fairly simple and everybody should be able to use it.
For now contro is succesfully tested on debian 7 and 8 other distros should work too.
# Installation
Install tomcat using apt. Copy the contro.war file to /var/lib/tomcat7/webapps. After a few sceonds the application is deployed and the application can be accessed via http://localhost:8080/contro
