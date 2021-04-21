from sqlalchemy import Column, String, Boolean, Integer
from sqlalchemy.orm import relationship

from conf.dao_postgre import start_session, close_session 
from conf.db_connection import Base
from conf.firebase_auth import sign_up
from models.tag import Tag
from models.tag_category import TagCategory
from models.user_tag import UserTag


def get(id):
    session = start_session()
    result = (session.query(User.id, User.name, User.age, User.is_admin)
              .filter(User.id == id).first())
    close_session(session)
    return result


def get_all():
    session = start_session()
    result = (session.query(User.id, User.name, User.age, User.is_admin).all())
    close_session(session)
    return result


def update(id, body):
    s = start_session()
    s.query(User).filter(User.id == id).update(body)
    close_session(s)


class User(Base):
    __tablename__ = 'user'
    __table_args__ = {"schema": "amigle"}

    id = Column(String, primary_key=True, unique=True)
    name = Column(String, nullable=False)
    age = Column(Integer, nullable=False)
    is_admin = Column(Boolean, nullable=False)

    # user_tags = relationship(UserTag, backref="user_tags")

    def __init__(self, id, name, age, is_admin):
        self.id = id
        self.name = name
        self.age = age
        self.is_admin = is_admin

    def create_firebase_user(self, email, password):
        response = sign_up(email, password)
        self.id = response['localId']
