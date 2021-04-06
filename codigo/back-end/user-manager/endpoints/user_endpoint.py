from functools import reduce
from flask import Blueprint, request, jsonify, Response, abort, make_response

from services import user_service

user = Blueprint('user', __name__)


@user.route("/user", methods=['POST'])
def insert():
    body = request.json
    if not validate_body_request(body, ["name", "age", "email", "is_admin"]): endpoints_exception(400, "INVALID_BODY")
    user_service.insert(body)


@user.route("/user/<int:id>", methods=['GET'])
def get(id):
    user_service.get(id)


@user.route("/user", methods=['GET'])
def get_all():
    user_service.get_all()


@user.route("/user/<int:id>", methods=['PUT'])
def update(id):
    body = request.json
    if not validate_body_request(body, ["name", "age", "email", "is_admin"]): endpoints_exception(400, "INVALID_BODY")
    user_service.update(id, body)


@user.route("/user/<int:id>", methods=['DELETE'])
def delete(id):
    user_service.delete(id)


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

