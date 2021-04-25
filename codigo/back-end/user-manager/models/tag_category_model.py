from sqlalchemy import Column, String, Integer
from sqlalchemy.orm import relationship

from conf.db_connection import Base, start_session, close_session


def update(id, body):
    session = start_session()
    session.query(TagCategory).filter(TagCategory.id == id).update(body)
    close_session(session)


class TagCategory(Base):
    __tablename__ = 'tag_category'
    __table_args__ = {"schema": "amigle"}

    id = Column(Integer, primary_key=True, unique=True)
    name = Column('name', String, nullable=False)
    tags = relationship("Tag", backref="tag_category")

    def __init__(self, id, name):
        self.id = id
        self.name = name
