from conf import dao_postgre
from models import tag_category
from models.tag_category import TagCategory
from dtos.tag_category_dto import TagCategoryDTO


def insert(body):
    dao_postgre.insert(TagCategory(None, body["name"]))


def get_all():
    tag_categories = dao_postgre.get_all(TagCategory)
    return format_json(tag_categories) if tag_categories is not None else None


def get(id):
    data = dao_postgre.get(TagCategory, id)
    return TagCategoryDTO(data.id, data.name).__dict__ if data is not None else None


def update(id, body):
    tag_category.update(id, body)


def delete(id):
    response = dao_postgre.delete(TagCategory, id)
    return response


def format_json(tag_categories):
    tag_categories_json = []

    for data in tag_categories:
        tag_categories_json.append(
            TagCategoryDTO(data.id, data.name).__dict__)
    return tag_categories_json
