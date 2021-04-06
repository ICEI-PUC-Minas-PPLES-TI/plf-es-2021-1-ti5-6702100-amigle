from sqlalchemy import Column, String, Boolean, Integer, ForeignKey
from conf.db_connection import Base


class Tag(Base):
    __tablename__ = 'tag'

    id = Column(Integer, primary_key=True, unique=True)
    name = Column(String, nullable=False)
    is_approved = Column(Boolean, nullable=False)
    tag_category_id = Column(Integer, ForeignKey('tag_category.id'))

    def __init__(self, id, name, tag_category_id, is_approved):
        self.id = id
        self.name = name
        self.tag_category_id = tag_category_id
        self.is_approved = is_approved
