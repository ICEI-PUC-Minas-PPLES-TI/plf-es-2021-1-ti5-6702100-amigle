from sqlalchemy import Column, String, Boolean, Integer
from conf.db_connection import Base
from conf.firebase_auth import sign_up


class User(Base):
    __tablename__ = 'user'

    id = Column(String, primary_key=True, unique=True)
    name = Column(String, nullable=False)
    age = Column(Integer, nullable=False)
    is_admin = Column(Boolean, nullable=False)

    def __init__(self, id, name, age, is_admin):
        self.id = id
        self.name = name
        self.age = age
        self.is_admin = is_admin

    def create_firebase_user(self, email, password):
        response = sign_up(email, password)
        self.id = response['localId']
