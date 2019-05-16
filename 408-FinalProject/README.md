# 408-finalproject

To setup the environment (assuming Python3 is already installed):
```
pip install flask
pip install sql
pip install mysql-connector-python
pip install csv
```

To setup the database:
```
Configure db.py file with your own credentials (if unchanged, default password is empty string)
mysql -u root -p 
Copy and paste contents of the blogdb.sql file into your mysql terminal and execute it
```

To run the project:
```
git clone https://github.com/Namsinh/408-finalproject.git
cd ~/408-finalproject/
export FLASK_APP=blogforum
export FLASK_ENV=development
Open Google Chrome browser
Navigate to localhost:5000 or 127.0.0.1:5000
```
To generate reports navigate to:
```
localhost:5000/generate
```



Resources:


https://scotch.io/tutorials/build-a-crud-web-app-with-python-and-flask-part-one

http://flask.pocoo.org/docs/1.0/tutorial/layout/

http://jinja.pocoo.org/docs/2.10/templates/

http://flask.pocoo.org/snippets/54/

https://stackoverflow.com/questions/26997679/writing-a-csv-from-flask-framework

https://www.codementor.io/adityamalviya/python-flask-mysql-connection-rxblpje73
