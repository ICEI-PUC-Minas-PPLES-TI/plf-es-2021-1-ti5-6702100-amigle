import os
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

host = os.environ.get('HOST')
port = os.environ.get('PORT')
username = os.environ.get('USERNAME')
password = os.environ.get('PASSWORD')
database = os.environ.get('DATABASE')

engine = create_engine(f'postgresql+psycopg2://{username}:{password}@{host}:{port}/{database}')
Session = sessionmaker(bind=engine)

Base = declarative_base()
Base.metadata.create_all(engine)


def start_session():
    # Create a new session
    return Session()


def close_session(session):
    session.commit()
    session.close()
