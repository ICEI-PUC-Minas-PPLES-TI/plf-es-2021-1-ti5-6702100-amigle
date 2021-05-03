from datetime import datetime

from conf import dao_postgre
from models import chat_model
from models.chat_model import Chat
from models.user_model import User
from services import user_service


def insert(body):
    return dao_postgre.insert(Chat(None, datetime.now(), None, body["firstUserId"], body["secondUserId"]))


def update(chat_id):
    body = {
        "end_date": datetime.now()
    }
    chat_model.update(chat_id, body)


def get_all():
    result = chat_model.get_all()
    if result is None:
        return None
    return format_json(result, None)


def get_all_by_user_id(user_id):
    result = chat_model.get_all_by_user(user_id)
    if result is None:
        return None
    return format_json(result, user_id)


def format_json(chats, user_id):
    chats_json = []

    for chat in chats:
        chat_object = {
            "id":  chat[0],
            "startDate": str(chat[1]),
            "endDate": str(chat[2])
        }

        if user_id is not None:
            guest_id = chat[3] if chat[3] != user_id else chat[4]
            guest_user = user_service.get(guest_id)
            chat_object["guestUserName"] = guest_user.name
        else:
            first_user = user_service.get(chat[3])
            second_user = user_service.get(chat[4])
            chat_object["users"] = {
                "firstUser": {"id": first_user.id, "name": first_user.name},
                "secondUser": {"id": second_user.id, "name": second_user.name}
            }

        chats_json.append(chat_object)
    return chats_json
