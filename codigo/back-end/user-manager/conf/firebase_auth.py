import json
import os
import pyrebase


def set_credential():
    with open(os.environ.get('PATH_CREDENTIALS')) as source:
        info = json.load(source)

    return pyrebase.initialize_app(info)


def sign_up(email, password):
    firebase = set_credential()
    auth = firebase.auth()
    return auth.create_user_with_email_and_password(email, password)


def login(email, password):
    firebase = set_credential()
    auth = firebase.auth()
    login_token = auth.sign_in_with_email_and_password(email, password)

    return login_token


def reset_password(self, email):
    firebase = self.set_credential()
    auth = firebase.auth()
    auth.send_password_reset_email(email)
