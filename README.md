# CSI 2132 Deliverable 2
Section A07 Group 14

## Team Members

* Elise Cloutier 300051115
* Chethin Manage 300066367
* Matt Tippin 300066841

## Instructions

### Instructions for Mac

1. Install XAMPP from [here](https://www.apachefriends.org/index.html)
2. Open XAMPP from your local machine and press "Start" in the General Tab
3. Configure PostgreSQL within the Virtual Development Environment
    - Navigate to the Volumes tab and click "Mount"
    - You will now be able to open a directory within the Virtual Development Environment.
    - The Folder will be visible as a USB Drive/Mount which you can access by clicking "Explore"
    - Navigate into root/etc and open php.ini with any text editor
    - Find the line ```;extension="pgsql.so"``` and remove the semicolon such that the line becomes ```extension="pgsql.so"```
4. Add repository PHP files to Virtual Development Environment
    - Save the file and navigate to root/htdocs
    - Delete everything there and replace it with the hotel folder of this repository
5. In hotel/settings.php, change the user and password to your own.
6. Go to the address provided in XAMPP by clicking "Go To Application" in the General Tab

### Instructions for Windows

1. Install XAMPP from [here](https://www.apachefriends.org/index.html)
2. Open XAMPP Control Panel from your local machine
3. Configure PostgreSQL within the Virtual Development Environment
    - Click Explorer To Navigate int
    - Search the directory for php.ini
    - Navigate into root/etc and open php.ini with any text editor
    - Find the lines ```;extension=pgsql.so``` and ```;extension=pdo_sql.so```
    - Remove the semicolon such that the lines become ```extension=pgsql``` and ```extension=pdo_sql"```
4. Add repository PHP files to Virtual Development Environment
    - Save the file and navigate to root/htdocs
    - Delete everything there and replace it with the hotel folder of this repository
5. In settings.php, change the user and password to your own
6. Start the Apache service from XAMPP Control Panel
7. Go to the address provided in XAMPP which is http://127.0.0.1 by default

### Instructions for Linux

1. Install php in terminal using ```sudo apt install php```
2. Install PGSQL for php using ```sudo apt install php-phsql```
3. Navigate into root project directory and then root/hotels
4. Run ```php -S 127.0.0.1:8000``` to start a server
5. In settings.php, change the user and password to your own.
6. View the application in your browser by navigating to the above address

## Troubleshooting
1. The web browser cannot reach site
    - Please make sure Apache is up and running in XAMPP control panel
2. Fatal error: Uncaught Error: Call to undefined function pg_connect()
    - Please make sure to enable PGSQL in XAMPP
    - Follow instruction 3 for Mac and Windows and instruction 2 for Linux
3. Web browser shows a blank page
    - Please make sure to enable PGSQL in XAMPP
    - Follow instruction 3 for Mac and Windows and instruction 2 for Linux

