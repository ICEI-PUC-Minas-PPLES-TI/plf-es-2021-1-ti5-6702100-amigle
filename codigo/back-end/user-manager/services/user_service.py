from conf import dao_postgre
from models import user
from models.user import User
from dtos.user_dto import UserDTO
from models.user_tag import UserTag


def insert(body):
    user = User("teste", body["name"], body["age"], False)
    user.create_firebase_user(body["email"], body["password"])
    dao_postgre.insert(user)


def get_all():
    return format_json(user.get_all())


def get(id):
    result = user.get(id)
    return UserDTO(result[0], result[1], result[2], result[3]).__dict__


def update(id, request_body):
    body = {}
    if "name" in request_body:
        body["name"] = request_body["name"]
    if "idAdmin" in request_body:
        body["is_admin"] = request_body["isAdmin"]
    if "age" in request_body:
        body["age"] = request_body["age"]
    user.update(id, body)


def delete(id):
    dao_postgre.delete(User, id)


def add_tag(id, tag_id):
    user_tag = UserTag(None, id, tag_id)
    # dao_postgre.insert(user)


def format_json(users):
    users_json = []

    for user in users:
        users_json.append(
            UserDTO(user.id, user.name, user.age, user.is_admin).__dict__)
    return users_json
