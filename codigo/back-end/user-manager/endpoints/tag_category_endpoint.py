from functools import reduce
from flask import Blueprint, request, jsonify, Response, make_response, abort

from services import tag_category_service

tag_category = Blueprint('tag_category', __name__)


@tag_category.route("/tag_category", methods=['POST'])
def insert():
    body = request.json
    if not validate_body_request(body, ["name"]):
        endpoints_exception(400, "INVALID_BODY")
    try:
        tag_category_service.insert(body)
        return Response('Added succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Insertion failed', mimetype='text/plain', status=401)


@tag_category.route("/tag_category/<int:id>", methods=['GET'])
def get(id):
    result = tag_category_service.get(id)
    return jsonify(result) if result is not None else "Not found"


@tag_category.route("/tag_category", methods=['GET'])
def get_all():
    result = tag_category_service.get_all()
    return jsonify(result) if result is not None else "Not found"


@tag_category.route("/tag_category/<int:id>", methods=['PUT'])
def update(id):
    body = request.json
    if not validate_body_request(body, ["name"]):
        endpoints_exception(400, "INVALID_BODY")
    try:
        tag_category_service.update(id, body)
        return Response('Updated succefully', mimetype='text/plain', status=200)
    except SystemError:
        return Response('Update failed', mimetype='text/plain', status=401)


@tag_category.route("/tag_category/<int:id>", methods=['DELETE'])
def delete(id):
    try:
        tag_category_service.delete(id)
        return Response('Deleted succefully', mimetype='text/plain', status=200)
    except SystemError:
        return Response('Deletion failed', mimetype='text/plain', status=401)


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
