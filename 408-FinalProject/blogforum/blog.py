from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for, send_file
)
from werkzeug.exceptions import abort

from blogforum.auth import login_required
from blogforum.db import get_db

from blogforum.generate_reports import generate_all_reports

bp = Blueprint('blog', __name__)

#index page to display all blog posts
@bp.route('/')
def index():

    db = get_db()
    db.cursor.execute(
        'SELECT p.postid, subject, body, postdate, creatorid, username'
        ' FROM posts p JOIN users u ON p.creatorid = u.userid'
        ' ORDER BY postdate DESC'
    )
    p = db.cursor.fetchall()

    return render_template('blog/index.html', posts=p)

#retrieve one post by id
def get_post(id, check_author=True):

    get_db().cursor.execute(
        'SELECT p.postid, subject, body, postdate, creatorid, username'
        ' FROM posts p JOIN users u ON p.creatorid = u.userid'
        ' WHERE p.postid = %s',
        (id,)
    )
    post = get_db().cursor.fetchone()

    if post is None:
        abort(404, "Post id {0} doesn't exist.".format(id))

    if check_author and post[4] != g.userid:
        abort(403)

    return post

#create a new post entry
@bp.route('/create', methods=('GET', 'POST'))
@login_required
def create():
    if request.method == 'POST':
        title = request.form['title']
        body = request.form['body']
        error = None

        if not title:
            error = 'Title is required.'

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.cursor.execute(
                'INSERT INTO posts (subject, body, creatorid)'
                ' VALUES (%s, %s, %s)',
                (title, body, g.userid)
            )
            db.commit()
            return redirect(url_for('blog.index'))

    return render_template('blog/create.html')

#search for a post by string
@bp.route('/search')
@bp.route('/search/<searchstring>', methods=('GET', 'POST'))
@login_required
def search(searchstring=""):

    s = searchstring
    if not s:
        s=""

    db = get_db()
    db.cursor.execute(
        'SELECT p.postid, subject, body, postdate, creatorid, username'
        ' FROM posts p JOIN users u ON p.creatorid = u.userid'
        ' WHERE body LIKE %s'
        ' OR subject LIKE %s'
        ' ORDER BY postdate DESC',
        ('%' + s + '%','%' + s + '%',)
    )
    p = db.cursor.fetchall()

    return render_template('blog/search.html', posts=p)

#update a post by id
@bp.route('/<int:id>/update', methods=('GET', 'POST'))
@login_required
def update(id):

    post = get_post(id)

    if request.method == 'POST':
        title = request.form['title']
        body = request.form['body']
        error = None

        if not title:
            error = 'Title is required.'

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.cursor.execute(
                'UPDATE posts SET subject = %s, body = %s WHERE postid = %s',
                (title, body, id)
            )
            db.commit()
            return redirect(url_for('blog.index'))

    return render_template('blog/update.html', post=post)

#delete a post by id
@bp.route('/<int:id>/delete', methods=('POST',))
@login_required
def delete(id):

    get_post(id)
    db = get_db()
    db.cursor.execute('DELETE FROM posts WHERE postid = %s', (id,))
    db.commit()
    return redirect(url_for('blog.index'))

#generate reports
@bp.route('/generate', methods=('GET','POST'))
@login_required
def generate_all():
    generate_all_reports()
    return render_template('blog/report.html')
#download user report (working)
@bp.route('/getUserReport')
@login_required
def user_report():
    return send_file('reports/user_report.csv',
                         mimetype='text/csv',
                         attachment_filename='user_report.csv',
                         as_attachment=True)
#download blog report -- in progress
@bp.route('/getPostReport')
@login_required
def post_report():
    return send_file('reports/blog_report.csv',
                         mimetype='text/csv',
                         attachment_filename='blog_report.csv',
                         as_attachment=True)
