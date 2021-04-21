from functools import reduce
from services import user_service
from conf.firebase_auth import login
from flask import Blueprint, request, jsonify, abort, make_response, Response

user = Blueprint('user', __name__)


@user.route("/user", methods=['POST'])
def insert():
    body = request.json
    if not validate_body_request(body, ["name", "age", "email", "password"]):
        endpoints_exception(400, "INVALID_BODY")
    try:
        user_service.insert(body)
        return Response('Added succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Insertion failed', mimetype='text/plain', status=401)


@user.route("/user/<string:id>/<int:tag_id>", methods=['POST'])
def add_tag(id, tag_id):
    try:
        user_service.add_tag(id, tag_id)
        return Response('Added succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Insertion failed', mimetype='text/plain', status=401)


@user.route("/user/<string:id>", methods=['GET'])
def get(id):
    response = user_service.get(id)
    return jsonify(response)


@user.route("/user", methods=['GET'])
def get_all():
    response = user_service.get_all()
    return jsonify(response)


@user.route("/user/<string:id>", methods=['PUT'])
def update(id):
    body = request.json
    if body is None:
        endpoints_exception(400, "INVALID_BODY")
    try:
        user_service.update(id, body)
        return Response('Updated succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Updated failed', mimetype='text/plain', status=401)


@user.route("/user/<string:id>", methods=['DELETE'])
def delete(id):
    try:
        user_service.delete(id)
        return Response('Deleted succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Deletion failed', mimetype='text/plain', status=401)


@user.route("/user/<string:user_id>/<int:tag_id>", methods=['DELETE'])
def delete_user_tag(user_id, tag_id):
    try:
        user_service.delete_user_tag(user_id, tag_id)
        return Response('Deleted succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Deletion failed', mimetype='text/plain', status=401)


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

