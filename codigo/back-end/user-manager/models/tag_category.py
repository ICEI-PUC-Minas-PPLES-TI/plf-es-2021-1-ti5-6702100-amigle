from sqlalchemy import Column, String, Integer

from conf.dao_postgre import start_session, close_session
from conf.db_connection import Base


def update(id, body):
    s = start_session()

    s.query(TagCategory).filter(TagCategory.id == id).update(body)
    close_session(s)


class TagCategory(Base):
    __tablename__ = 'tag_category'
    __table_args__ = {"schema": "amigle"}

    id = Column(Integer, primary_key=True, unique=True)
    name = Column(String, nullable=False)

    # tags = relationship(Tag, backref="tags")

    def __init__(self, id, name):
        self.id = id
        self.name = name

