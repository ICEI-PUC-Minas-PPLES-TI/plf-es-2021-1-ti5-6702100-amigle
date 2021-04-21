from dtos.tag_dto import TagDTO
from models import tag
from models.tag import Tag
from conf import dao_postgre
from services import user_service


def insert(user_id, body):
    is_approved = user_service.get(user_id)["isAdmin"]
    category_id = body["categoryId"] if is_approved and "categoryId" in body else 1
    dao_postgre.insert(Tag(None, body["name"], category_id, is_approved))


def get_all():
    return format_json(tag.get_all())


def get_all_by_category(category_id):
    return format_json(tag.get_all_by_category(category_id))


def get(id):
    result = tag.get(id)
    return TagDTO(result[0], result[1], result[2], result[3]).__dict__


def search_by_name(name):
    return format_json(tag.search_by_name(name))


def update(id, request_body):
    body = {}
    if "name" in request_body:
        body["name"] = request_body["name"]
    if "categoryId" in request_body:
        body["tag_category_id"] = request_body["categoryId"]
    if "isApproved" in request_body:
        body["is_approved"] = request_body["isApproved"]
    tag.update(id, body)


def delete(id):
    dao_postgre.delete(Tag, id)


def format_json(tags):
    tags_json = []

    for tag in tags:
        tags_json.append(TagDTO(tag[0], tag[1], tag[2], tag[3]).__dict__)
    return tags_json
