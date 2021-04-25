from sqlalchemy import Column, String, Boolean, Integer, ForeignKey

from conf.db_connection import Base, start_session, close_session
from models.tag_category_model import TagCategory
from models.user_tag_model import UserTag


def get_all():
    session = start_session()
    result = (session.query(Tag.id, Tag.name, Tag.is_approved, TagCategory.id, TagCategory.name)
              .join(TagCategory, Tag.tag_category_id == TagCategory.id)).all()
    close_session(session)
    return result


def get_all_by_category(category_id):
    session = start_session()
    result = (session.query(Tag.id, Tag.name, Tag.is_approved, TagCategory.id, TagCategory.name)
              .join(TagCategory, Tag.tag_category_id == TagCategory.id)).filter(TagCategory.id == category_id).all()
    close_session(session)
    return result


def get_all_by_user(user_id):
    session = start_session()
    result = (session.query(Tag.id, Tag.name, Tag.is_approved, TagCategory.id, TagCategory.name)
              .join(TagCategory, TagCategory.id == Tag.tag_category_id)
              .join(UserTag, UserTag.tag_id == Tag.id)
              ).filter(UserTag.user_id == user_id).all()
    close_session(session)
    return result


def get(id):
    session = start_session()
    result = (session.query(Tag.id, Tag.name, Tag.is_approved, TagCategory.id, TagCategory.name)
              .join(TagCategory, Tag.tag_category_id == TagCategory.id)
              ).filter(Tag.id == id).first()
    close_session(session)
    return result


def search_by_name(name):
    session = start_session()
    result = (session.query(Tag.id, Tag.name, Tag.is_approved, TagCategory.id, TagCategory.name)
              .join(TagCategory, Tag.tag_category_id == TagCategory.id)).filter(Tag.name.like(f'%{name}%')).all()
    close_session(session)
    return result


def update(id, body):
    session = start_session()
    session.query(Tag).filter(Tag.id == id).update(body)
    close_session(session)


class Tag(Base):
    __tablename__ = 'tag'
    __table_args__ = {"schema": "amigle"}

    id = Column(Integer, primary_key=True, unique=True)
    name = Column(String, nullable=False)
    is_approved = Column(Boolean, nullable=False)
    tag_category_id = Column(Integer, ForeignKey('amigle.tag_category.id'))

    def __init__(self, id, name, is_approved, tag_category_id):
        self.id = id
        self.name = name
        self.is_approved = is_approved
        self.tag_category_id = tag_category_id
