from sqlalchemy import Column, String, Boolean, Integer, Table, ForeignKey, Date
from sqlalchemy.orm import relationship

from conf.db_connection import Base, start_session, close_session
from conf.firebase_auth import sign_up
from models.user_tag_model import UserTag


def get(id):
    session = start_session()
    result = (session.query(User.id, User.name, User.birth_date, User.is_admin, User.profile_pic)
              .filter(User.id == id).first())
    close_session(session)
    return result


def get_all():
    session = start_session()
    result = (session.query(User.id, User.name, User.birth_date, User.is_admin, User.profile_pic).all())
    close_session(session)
    return result


def update(id, body):
    session = start_session()
    session.query(User).filter(User.id == id).update(body)
    close_session(session)


def delete_user_tag(user_id, tag_id):
    session = start_session()
    session.query(UserTag).filter(UserTag.user_id == user_id, UserTag.tag_id == tag_id).delete()
    close_session(session)


users_tags_association = Table('user_tag', Base.metadata,
                               Column('user_id', Integer, ForeignKey('amigle.user.id')),
                               Column('tag_id', Integer, ForeignKey('amigle.tag.id'))
                               )


class User(Base):
    __tablename__ = 'user'
    __table_args__ = {"schema": "amigle"}

    id = Column(String, primary_key=True, unique=True)
    name = Column(String, nullable=False)
    birth_date = Column(Date, nullable=False)
    is_admin = Column(Boolean, nullable=False)
    profile_pic = Column(String)

    tags = relationship("Tag", secondary=users_tags_association)

    def __init__(self, id, name, birth_date, is_admin, profile_pic):
        self.id = id
        self.name = name
        self.birth_date = birth_date
        self.is_admin = is_admin
        self.profile_pic = profile_pic

    def create_firebase_user(self, email, password):
        response = sign_up(email, password)
        self.id = response['localId']
