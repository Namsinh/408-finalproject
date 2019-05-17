import os
from flask import Flask

#Initialization
#Create flask application, register database commands

def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        # a default secret that should be overridden by instance config
        SECRET_KEY='dev',
        # store the database in the instance folder
        DATABASE=os.path.join(app.instance_path, 'bretboard.sqlite'),)

    if test_config is None:
        app.config.from_pyfile('config.py', silent=True)
    else:
        app.config.update(test_config)

    # check if instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # register the database commands
    from blogforum import db
    db.init_app(app)

    # apply the blueprints to the app
    from blogforum import auth, blog
    app.register_blueprint(auth.bp)
    app.register_blueprint(blog.bp)

    app.add_url_rule('/', endpoint='index')

    return app
