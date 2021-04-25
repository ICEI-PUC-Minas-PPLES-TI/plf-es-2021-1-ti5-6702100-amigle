from models import tag_model
from models.tag_category_model import TagCategory
from models.tag_model import Tag
from conf import dao_postgre
from services import user_service


def insert(user_id, body):
    is_approved = user_service.get(user_id)["isAdmin"]
    category_id = body["categoryId"] if is_approved and "categoryId" in body else 1
    dao_postgre.insert(Tag(None, body["name"], category_id, is_approved))


def get_all():
    result = tag_model.get_all()
    if result is None:
        return None
    return format_json(result)


def get_all_by_category(category_id):
    result = tag_model.get_all_by_category(category_id)
    if result is None:
        return None
    return format_json(result)


def get_all_by_user(user_id):
    result = tag_model.get_all_by_user(user_id)
    if result is None:
        return None
    return format_json(result)


def get(tag_id):
    result = tag_model.get(tag_id)
    if result is None:
        return None

    tag = Tag(id=result[0], name=result[1], is_approved=result[2], tag_category_id=result[3])
    tag.tag_category = TagCategory(id=result[3], name=result[4])
    return tag


def search_by_name(name):
    result = tag_model.search_by_name(name)
    if result is None:
        return None
    return format_json(result)


def update(tag_id, request_body):
    body = {}
    if "name" in request_body:
        body["name"] = request_body["name"]
    if "categoryId" in request_body:
        body["tag_category_id"] = request_body["categoryId"]
    if "isApproved" in request_body:
        body["is_approved"] = request_body["isApproved"]
    tag_model.update(tag_id, body)


def delete(tag_id):
    dao_postgre.delete(Tag, tag_id)


def format_json(tags):
    tags_json = []

    for tag in tags:
        tag_object = Tag(id=tag[0], name=tag[1], is_approved=tag[2], tag_category_id=tag[3])
        tag_object.tag_category = TagCategory(id=tag[3], name=tag[4])
        tags_json.append(tag_object)
    return tags_json
