from functools import reduce
from flask import Blueprint, request, jsonify, Response, make_response, abort

from services import tag_service

tag = Blueprint('tag', __name__)


@tag.route("/tag", methods=['POST'])
def insert():
    body = request.json
    if not validate_body_request(body, ["name", "category", "is_approved"]): endpoints_exception(400, "INVALID_BODY")
    tag_service.insert(body)


@tag.route("/tag/<int:id>", methods=['GET'])
def get(id):
    tag_service.get(id)


@tag.route("/tag", methods=['GET'])
def get_all():
    tag_service.get_all()


@tag.route("/tag/<int:id>", methods=['PUT'])
def update(id):
    body = request.json
    if not validate_body_request(body, ["name", "category", "is_approved"]): endpoints_exception(400, "INVALID_BODY")
    tag_service.update(id, body)


@tag.route("/tag/<int:id>", methods=['DELETE'])
def delete(id):
    tag_service.delete(id)


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
