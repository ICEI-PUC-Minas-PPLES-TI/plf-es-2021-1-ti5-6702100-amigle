from datetime import datetime
from functools import reduce

from dtos import dto_formatter
from services import user_service
from conf.firebase_auth import login
from flask import Blueprint, request, jsonify, abort, make_response, Response

user = Blueprint('user', __name__)


@user.route("/user", methods=['POST'])
def insert():
    body = request.args
    if not validate_body_request(body, ["name", "birthDate", "email", "password"]):
        endpoints_exception(400, "INVALID_BODY")

    birth_date = datetime.fromisoformat(body["birthDate"]).date()
    if datetime.now().date().year - birth_date.year < 13:
        endpoints_exception(400, "INVALID_BIRTH_DATE")
    try:
        user_service.insert(body)
        return Response('Added succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Insertion failed', mimetype='text/plain', status=401)


@user.route("/user/<string:user_id>", methods=['POST'])
def add_profile_pic(user_id):
    profile_pic = request.files.get('profilePic')
    try:
        user_service.add_profile_pic(user_id, profile_pic)
        return Response('Added succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Insertion failed', mimetype='text/plain', status=401)


@user.route("/user/<string:user_id>/<int:tag_id>", methods=['POST'])
def add_tag(user_id, tag_id):
    try:
        user_service.add_tag(user_id, tag_id)
        return Response('Added succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Insertion failed', mimetype='text/plain', status=401)


@user.route("/user/<string:user_id>", methods=['GET'])
def get(user_id):
    user_object = user_service.get(user_id)
    if user_object is None:
        endpoints_exception(200, 'No record found')
    user_dto = dto_formatter.user_dto(user_object)
    return jsonify(user_dto)


@user.route("/user", methods=['GET'])
def get_all():
    users_object = user_service.get_all()

    result = []
    for user_object in users_object:
        user_dto = dto_formatter.user_dto(user_object)
        result.append(user_dto)

    return jsonify(result)


@user.route("/user/<string:user_id>", methods=['PUT'])
def update(user_id):
    body = request.json
    if body is None:
        endpoints_exception(400, "INVALID_BODY")
    if "birthDate" in body:
        birth_date = datetime.fromisoformat(body["birthDate"]).date()
        if datetime.now().date().year - birth_date.year < 13:
           endpoints_exception(400, "INVALID_BIRTH_DATE")
    try:
        user_service.update(user_id, body)
        return Response('Updated succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Updated failed', mimetype='text/plain', status=401)


@user.route("/user/<string:user_id>", methods=['DELETE'])
def delete(user_id):
    try:
        user_service.delete(user_id)
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
    email = request.json['email']
    password = request.json['password']

    auth = login(email, password)
    user_id = auth['localId']

    user_dto = dto_formatter.user_dto(user_service.get(user_id))
    return jsonify(user_dto)


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
