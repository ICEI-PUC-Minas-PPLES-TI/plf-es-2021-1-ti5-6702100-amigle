from sqlalchemy import DateTime, String, Column, ForeignKey, Integer

from conf.db_connection import Base, start_session, close_session
from models.user_model import User


def update(chat_id, body):
    session = start_session()
    session.query(Chat).filter(Chat.id == chat_id).update(body)
    close_session(session)


def get_all():
    session = start_session()
    result = (session.query(Chat.id, Chat.start_date, Chat.end_date, Chat.first_user_id, Chat.second_user_id)
              .join(User, User.id == Chat.first_user_id or User.id == Chat.second_user_id)
              ).all()
    close_session(session)
    return result


def get_all_by_user(user_id):
    session = start_session()

    chats = []

    result = (session.query(Chat.id, Chat.start_date, Chat.end_date, Chat.first_user_id, Chat.second_user_id)
              .join(User, User.id == Chat.first_user_id or User.id == Chat.second_user_id)
              ).all()

    for chat in result:
        if (chat.first_user_id == user_id or chat.second_user_id == user_id) and chat.end_date is not None:
            chats.append(chat)

    close_session(session)
    return chats


class Chat(Base):
    __tablename__ = 'chat'
    __table_args__ = {"schema": "amigle"}

    id = Column(Integer, primary_key=True, unique=True)
    start_date = Column(DateTime, nullable=False)
    end_date = Column(DateTime)
    first_user_id = Column(String, ForeignKey('amigle.user.id'))
    second_user_id = Column(String, ForeignKey('amigle.user.id'))

    def __init__(self, id, start_date, end_date, first_user_id, second_user_id):
        self.id = id
        self.start_date = start_date
        self.end_date = end_date
        self.first_user_id = first_user_id
        self.second_user_id = second_user_id
