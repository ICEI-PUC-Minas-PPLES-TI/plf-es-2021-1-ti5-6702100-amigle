from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.orm import relationship

from conf.dao_postgre import start_session, close_session
from conf.db_connection import Base


def delete_user_tag(user_id, tag_id):
    session = start_session()
    session.query(UserTag).filter(UserTag.user_id == user_id, UserTag.tag_id == tag_id).delete()
    close_session(session)


class UserTag(Base):
    __tablename__ = 'user_tag'
    __table_args__ = {"schema": "amigle"}

    id = Column(Integer, primary_key=True, unique=True)
    user_id = Column(String, ForeignKey('amigle.user.id'))
    tag_id = Column(Integer, ForeignKey('amigle.tag.id'))

    # tag = relationship('Tag')
    # user = relationship('User')

    def __init__(self, id, user_id, tag_id):
        self.id = id
        self.user_id = user_id
        self.tag_id = tag_id
