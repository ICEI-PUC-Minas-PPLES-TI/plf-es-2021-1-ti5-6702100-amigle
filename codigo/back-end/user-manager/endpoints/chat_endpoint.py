from functools import reduce

from services import chat_service
from flask import Blueprint, request, jsonify, abort, make_response, Response

chat = Blueprint('chat', __name__)


@chat.route("/chat", methods=['POST'])
def insert():
    body = request.json
    if not validate_body_request(body, ["firstUserId", "secondUserId"]):
        endpoints_exception(400, "INVALID_BODY")

    try:
        chat_id = chat_service.insert(body)
        return jsonify({"chatId": chat_id})
    except SystemError:
        return Response('Insertion failed', mimetype='text/plain', status=401)


@chat.route("/chat", methods=['GET'])
def get_all():
    chats_object = chat_service.get_all()
    return jsonify(chats_object)


@chat.route("/chat/<string:user_id>", methods=['GET'])
def get_all_by_user_id(user_id):
    chats_object = chat_service.get_all_by_user_id(user_id)
    return jsonify(chats_object)


@chat.route("/chat/<string:chat_id>", methods=['PUT'])
def update(chat_id):
    try:
        chat_service.update(chat_id)
        return Response('Updated succefully', mimetype='text/plain', status=201)
    except SystemError:
        return Response('Updated failed', mimetype='text/plain', status=401)


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
