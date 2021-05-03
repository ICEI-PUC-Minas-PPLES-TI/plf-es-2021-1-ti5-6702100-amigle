from flask import Flask

from endpoints.chat_endpoint import chat
from endpoints.tag_endpoint import tag
from endpoints.user_endpoint import user
from endpoints.tag_category_endpoint import tag_category
from flask import Flask
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

app.register_blueprint(tag)
app.register_blueprint(user)
app.register_blueprint(chat)
app.register_blueprint(tag_category)


@app.route('/')
def user_manager():
    return 'user-manager'


if __name__ == '__main__':
    app.run()
