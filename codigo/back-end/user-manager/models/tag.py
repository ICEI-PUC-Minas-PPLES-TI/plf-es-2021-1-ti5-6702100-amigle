from sqlalchemy import Column, String, Boolean, Integer, ForeignKey

from conf.dao_postgre import start_session, close_session
from conf.db_connection import Base
from models.tag_category import TagCategory


def get_all():
    s = start_session()
    result = (s.query(Tag.id, Tag.name, TagCategory.name, Tag.is_approved)
              .join(TagCategory, Tag.tag_category_id == TagCategory.id)).all()
    close_session(s)
    return result


def get_all_by_category(category_id):
    s = start_session()
    result = (s.query(Tag.id, Tag.name, TagCategory.name, Tag.is_approved)
              .join(TagCategory, Tag.tag_category_id == TagCategory.id)).filter(TagCategory.id == category_id).all()
    close_session(s)
    return result


def get(id):
    s = start_session()
    result = (s.query(Tag.id, Tag.name, TagCategory.name, Tag.is_approved)
              .join(TagCategory, Tag.tag_category_id == TagCategory.id)).filter(Tag.id == id).first()
    close_session(s)
    return result


def search_by_name(name):
    s = start_session()
    result = (s.query(Tag.id, Tag.name, TagCategory.name, Tag.is_approved)
              .join(TagCategory, Tag.tag_category_id == TagCategory.id)).filter(Tag.name.like(f'%{name}%')).all()
    close_session(s)
    return result


def update(id, body):
    s = start_session()
    s.query(Tag).filter(Tag.id == id).update(body)
    close_session(s)


class Tag(Base):
    __tablename__ = 'tag'
    __table_args__ = {"schema": "amigle"}

    id = Column(Integer, primary_key=True, unique=True)
    name = Column(String, nullable=False)
    is_approved = Column(Boolean, nullable=False)
    tag_category_id = Column(Integer, ForeignKey('amigle.tag_category.id'))

    # tags_user = relationship(UserTag, backref="tags_user")
    # tag_category = relationship('TagCategory')

    def __init__(self, id, name, tag_category_id, is_approved):
        self.id = id
        self.name = name
        self.tag_category_id = tag_category_id
        self.is_approved = is_approved

