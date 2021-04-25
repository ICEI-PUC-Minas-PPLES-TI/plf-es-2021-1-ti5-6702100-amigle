from functools import reduce
from flask import Blueprint, request, jsonify, Response, make_response, abort

from dtos import dto_formatter
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


@tag.route("/tag/<int:tag_id>", methods=['GET'])
def get(tag_id):
    tag_object = tag_service.get(tag_id)
    if tag_object is None:
        endpoints_exception(200, 'No record found')
    tag_dto = dto_formatter.tag_dto(tag_object)
    return jsonify(tag_dto)


@tag.route("/tag", methods=['GET'])
def get_all():
    tags_object = None
    body = request.json
    if body is None:
        tags_object = tag_service.get_all()
    elif "name" in body:
        tags_object = tag_service.search_by_name(body["name"])
    elif "categoryId" in body:
        tags_object = tag_service.get_all_by_category(body["categoryId"])

    result = []
    for tag_object in tags_object:
        tag_dto = dto_formatter.tag_dto(tag_object)
        result.append(tag_dto)

    return jsonify(result)


@tag.route("/tag/<int:tag_id>", methods=['PUT'])
def update(tag_id):
    body = request.json
    if body is None:
        endpoints_exception(400, "INVALID_BODY")
    try:
        tag_service.update(tag_id, body)
        return Response('Updated succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Update failed', mimetype='text/plain', status=401)


@tag.route("/tag/<int:tag_id>", methods=['DELETE'])
def delete(tag_id):
    try:
        tag_service.delete(tag_id)
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
