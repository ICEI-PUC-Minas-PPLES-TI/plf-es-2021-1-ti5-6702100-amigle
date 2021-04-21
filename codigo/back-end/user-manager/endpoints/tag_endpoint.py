from functools import reduce
from flask import Blueprint, request, jsonify, Response, make_response, abort

from services import tag_service

tag = Blueprint('tag', __name__)


@tag.route("/tag/<string:user_id>", methods=['POST'])
def insert(user_id):
    body = request.json
    if body is None:
        endpoints_exception(400, "INVALID_BODY")
    try:
        tag_service.insert(user_id, body)
        return Response('Added succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Insertion failed', mimetype='text/plain', status=401)


@tag.route("/tag/<int:id>", methods=['GET'])
def get(id):
    return jsonify(tag_service.get(id))


@tag.route("/tag", methods=['GET'])
def get_all():
    result = None
    body = request.json
    if body is None:
        result = tag_service.get_all()
    elif "name" in body:
        result = tag_service.search_by_name(body["name"])
    elif "categoryId" in body:
        result = tag_service.get_all_by_category(body["categoryId"])

    return jsonify(result) if result is not None else "Not found"


@tag.route("/tag/<int:id>", methods=['PUT'])
def update(id):
    body = request.json
    if body is None:
        endpoints_exception(400, "INVALID_BODY")
    try:
        tag_service.update(id, body)
        return Response('Updated succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Update failed', mimetype='text/plain', status=401)


@tag.route("/tag/<int:id>", methods=['DELETE'])
def delete(id):
    try:
        tag_service.delete(id)
        return Response('Deleted succefully', mimetype='text/plain', status=201)
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
