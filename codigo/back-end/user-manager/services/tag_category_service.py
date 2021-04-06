from conf.dao_postgre import start_session, close_session
from models.tag_category import TagCategory


def insert(body):
    insert(TagCategory(None, body["name"]))


def get_all():
    tag_categories = get_all(TagCategory)
    return format_json(tag_categories)


def get(id):
    tag_category = get(TagCategory, id)
    tag_category = tag_category.__dict__
    return TagCategoryDTO(tag_category['id'], tag_category['name']).__dict__


def update(id, body):
    s = start_session()

    s.query(TagCategory).filter(TagCategory.id == id).update({
        'name': body["name"],
    })
    close_session(s)


def delete(id):
    delete(TagCategory, id)


def format_json(tag_categories):
    tag_categories_json = []

    for tag_category in tag_categories:
        tag_category = tag_category.__dict__
        tag_categories_json.append(
            TagCategoryDTO(tag_category['id'], tag_category['name']).__dict__)
    return tag_categories_json
