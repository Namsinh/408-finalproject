from blogforum.db import get_db
import mysql.connector as sql
import csv

config = {
  'user': 'root',
  'password': 'p',
  'host': '127.0.0.1',
  'database': 'blogdb',
  'raise_on_warnings': True,
}

#saves user report csv to server to be downloaded
def generate_userreport():

    cnx = sql.connect(**config)
    cursor = cnx.cursor()

    query = ("SELECT userId,username,firstName,lastName,dateCreated FROM Users")

    cursor.execute(query)

    all_users = cursor.fetchall()

    out = [["User ID","Username","First Name","Last Name","Account Created"]]

    for u in all_users:
        iout = []
        for i in range(len(u)):
            iout.append(u[i])
        out.append(iout)

    with open("blogforum/reports/user_report.csv", 'w+') as f:
        writer = csv.writer(f)
        writer.writerows(out)

#saves report to csv file to server to be downloaded
def generate_blogreport():

    cnx = sql.connect(**config)
    cursor = cnx.cursor()

    query = ("SELECT postid,u.username,postdate,subject,body FROM posts p JOIN Users u ON p.creatorid=u.userID")

    cursor.execute(query)

    all_posts = cursor.fetchall()

    out = [["Post ID","Username","Post Date","Title","Body"] ]

    for p in all_posts:
        iout = []
        for i in range(len(p)):
            iout.append(p[i])
        out.append(iout)

    with open("blogforum/reports/blog_report.csv", 'w+') as f:
        writer = csv.writer(f)
        writer.writerows(out)


def generate_all_reports():
    generate_userreport()
    generate_blogreport()
