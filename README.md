# 408-finalproject

To setup the environment:
```
pip install flask
pip install sql
pip install mysql-connector-python
pip install csv
```

To setup the database:
```
mysql -u root -p 
Configure db.py file with your own necessary credentials
Copy and paste contents of the blogdb.sql file into your mysql terminal and execute it
```

To run the project:
```
cd ~/408-finalproject/
export FLASK_APP=blogforum
export FLASK_ENV=development
Open Google Chrome browser
Navigate to localhost:5000 or 127.0.0.1:5000
```

Resources:
https://scotch.io/tutorials/build-a-crud-web-app-with-python-and-flask-part-one

http://flask.pocoo.org/docs/1.0/tutorial/layout/

https://stackoverflow.com/questions/26997679/writing-a-csv-from-flask-framework

https://www.codementor.io/adityamalviya/python-flask-mysql-connection-rxblpje73
