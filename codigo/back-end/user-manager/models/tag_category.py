from sqlalchemy import Column, String, Integer
from conf.db_connection import Base


class TagCategory(Base):
    __tablename__ = 'tag_category'
    __table_args__ = {"schema": "amigle"}

    id = Column(Integer, primary_key=True, unique=True)
    name = Column(String, nullable=False)

    def __init__(self, id, name):
        self.id = id
        self.name = name
