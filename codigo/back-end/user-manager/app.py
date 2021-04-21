from flask import Flask

from endpoints.tag_endpoint import tag
from endpoints.user_endpoint import user
from endpoints.tag_category_endpoint import tag_category

app = Flask(__name__)

app.register_blueprint(user)
app.register_blueprint(tag)
app.register_blueprint(tag_category)


@app.route('/')
def user_manager():
    return 'user-manager'


if __name__ == '__main__':
    app.run()