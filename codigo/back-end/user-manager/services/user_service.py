from conf import dao_postgre, firebase_storage
from models import user_model, tag_model, user_tag_model
from models.user_model import User
from models.user_tag_model import UserTag
from services import tag_service


def insert(body):
    user = User(None, body["name"], body["birthDate"], False, None)
    user.create_firebase_user(body["email"], body["password"])
    dao_postgre.insert(user)


def add_profile_pic(user_id, profile_pic):
    img_path = firebase_storage.upload_image_file(profile_pic, "profile_pic")
    body = {"profile_pic": img_path}
    user_model.update(user_id, body)


def get_all():
    result = user_model.get_all()
    if result is None:
        return None
    return format_json(result)


def get(user_id):
    result = user_model.get(user_id)
    if result is None:
        return None
    user = User(result[0], result[1], result[2], result[3], result[4])
    user.tags = tag_service.get_all_by_user(user_id)
    return user


def update(user_id, request_body):
    body = {}
    if "name" in request_body:
        body["name"] = request_body["name"]
    if "isAdmin" in request_body:
        body["is_admin"] = request_body["isAdmin"]
    if "birthDate" in request_body:
        body["birth_date"] = request_body["birthDate"]
    user_model.update(user_id, body)


def delete(user_id):
    dao_postgre.delete(User, user_id)


def delete_user_tag(user_id, tag_id):
    user_tag_model.delete_user_tag(user_id, tag_id)


def add_tag(user_id, tag_id):
    user_tag = UserTag(None, user_id, tag_id)
    dao_postgre.insert(user_tag)


def format_json(users):
    users_json = []

    for user in users:
        users_json.append(User(user.id, user.name, user.birth_date, user.is_admin, user.profile_pic))
    return users_json
