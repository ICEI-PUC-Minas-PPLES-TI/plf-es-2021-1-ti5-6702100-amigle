from conf.dao_postgre import start_session, close_session
from dtos.tag_dto import TagDTO
from models.tag import Tag
from conf import dao_postgre


def insert(body):
    dao_postgre.insert(Tag(None, body["name"], body["tag_category_id"], body["is_approved"]))


def get_all():
    tags = dao_postgre.get_all(Tag)
    return format_json(tags)


def get(id):
    tag = dao_postgre.get(Tag, id)
    tag = tag.__dict__
    return TagDTO(tag['id'], tag['name'], tag['tag_category_id'], tag['is_approved']).__dict__


def update(id, body):
    s = start_session()

    s.query(Tag).filter(Tag.id == id).update({
        'name': body["name"],
        'tag_category_id': body["tag_category_id"],
        'is_approved': body["is_approved"],
    })
    close_session(s)


def delete(id):
    dao_postgre.delete(Tag, id)


def format_json(tags):
    tags_json = []

    for tag in tags:
        tag = tag.__dict__
        tags_json.append(
            TagDTO(tag['id'], tag['name'], tag['tag_category_id'], tag['is_approved']).__dict__)
    return tags_json
