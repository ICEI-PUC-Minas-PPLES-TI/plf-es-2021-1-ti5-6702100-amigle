from functools import reduce
from flask import Blueprint, request, jsonify, Response, make_response, abort

from dtos import dto_formatter
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


@tag_category.route("/tag_category/<int:category_id>", methods=['GET'])
def get(category_id):
    category_object = tag_category_service.get(category_id)
    if category_object is None:
        endpoints_exception(200, 'No record found')
    category_dto = dto_formatter.category_dto(category_object)
    return jsonify(category_dto)


@tag_category.route("/tag_category", methods=['GET'])
def get_all():
    categories_object = tag_category_service.get_all()

    result = []
    for category_object in categories_object:
        category_dto = dto_formatter.category_dto(category_object)
        result.append(category_dto)
    return jsonify(result)


@tag_category.route("/tag_category/<int:category_id>", methods=['PUT'])
def update(category_id):
    body = request.json
    if not validate_body_request(body, ["name"]):
        endpoints_exception(400, "INVALID_BODY")
    try:
        tag_category_service.update(category_id, body)
        return Response('Updated succefully', mimetype='text/plain', status=200)
    except SystemError:
        return Response('Update failed', mimetype='text/plain', status=401)


@tag_category.route("/tag_category/<int:category_id>", methods=['DELETE'])
def delete(category_id):
    try:
        tag_category_service.delete(category_id)
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
