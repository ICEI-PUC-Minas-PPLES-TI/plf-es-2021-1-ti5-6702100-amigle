from conf import dao_postgre
from models import tag_category_model
from models.tag_category_model import TagCategory


def insert(body):
    dao_postgre.insert(TagCategory(None, body["name"]))


def get_all():
    result = dao_postgre.get_all(TagCategory)
    if result is None:
        return None
    return format_json(result)


def get(category_id):
    result = dao_postgre.get(TagCategory, category_id)
    if result is None:
        return None
    return TagCategory(result.id, result.name)


def update(category_id, body):
    tag_category_model.update(category_id, body)


def delete(category_id):
    dao_postgre.delete(TagCategory, category_id)


def format_json(tag_categories):
    tag_categories_json = []

    for tag_category in tag_categories:
        tag_categories_json.append(
            TagCategory(tag_category.id, tag_category.name))
    return tag_categories_json
