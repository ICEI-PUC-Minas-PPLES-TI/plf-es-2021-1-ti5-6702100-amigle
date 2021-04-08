from functools import reduce
from services import user_service
from conf.firebase_auth import login
from flask import Blueprint, request, jsonify, abort, make_response

user = Blueprint('user', __name__)


@user.route("/user", methods=['POST'])
def insert():
    body = request.json
    if not validate_body_request(body, ["name", "age", "email", "isAdmin", "password"]): endpoints_exception(400, "INVALID_BODY")
    user_service.insert(body)


@user.route("/user/<int:id>", methods=['GET'])
def get(id):
    response = user_service.get(id)
    return jsonify(response)


@user.route("/user", methods=['GET'])
def get_all():
    response = user_service.get_all()
    return jsonify(response)


@user.route("/user/<int:id>", methods=['PUT'])
def update(id):
    body = request.json
    if not validate_body_request(body, ["name", "age", "email", "is_admin"]): endpoints_exception(400, "INVALID_BODY")
    user_service.update(id, body)


@user.route("/user/<int:id>", methods=['DELETE'])
def delete(id):
    user_service.delete(id)


@user.route("/user/login", methods=['POST'])
def login_with_email_and_password():
    email = request.form['email']
    password = request.form['password']
    auth = login(email, password)
    id = auth['localId']

    return jsonify(user_service.get(id))


def validate_body_request(body, properties):
    if not body:
        return True
    return reduce(
        lambda x, y: x and y,
        map(
            lambda x: True if x in properties else False,
            body
        )
    )


def endpoints_exception(code, msg):
    abort(make_response(jsonify(message=msg), code))

