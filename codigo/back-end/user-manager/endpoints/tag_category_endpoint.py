from functools import reduce
from flask import Blueprint, request, jsonify, Response, make_response, abort

from services import tag_category_service

tag_category = Blueprint('tag_category', __name__)


@tag_category.route("/tag_category", methods=['POST'])
def insert():
    body = request.json
    if not validate_body_request(body, ["name"]): endpoints_exception(400, "INVALID_BODY")
    tag_category_service.insert(body)


@tag_category.route("/tag_category/<int:id>", methods=['GET'])
def get(id):
    return jsonify(tag_category_service.get(id))


@tag_category.route("/tag_category", methods=['GET'])
def get_all():
    return jsonify(tag_category_service.get_all())


@tag_category.route("/tag_category/<int:id>", methods=['PUT'])
def update(id):
    body = request.json
    if not validate_body_request(body, ["name"]): endpoints_exception(400, "INVALID_BODY")
    tag_category_service.update(id, body)


@tag_category.route("/tag_category/<int:id>", methods=['DELETE'])
def delete(id):
    tag_category_service.delete(id)


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
