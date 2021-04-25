from conf.db_connection import start_session, close_session


def insert(data):
    session = start_session()
    session.add(data)
    session.commit()
    session.refresh(data)
    id = data.id

    session.close()
    return id


def get_all(type_class):
    session = start_session()
    data = session.query(type_class).all()
    return data


def get(type_class, id):
    session = start_session()
    data = session.query(type_class).get(id)
    return data


def update(type_class, id, data):
    session = start_session()
    data = session.query(type_class).update()
    session.add(data)
    close_session(session)


def delete(type_class, id):
    session = start_session()
    session.query(type_class).filter(type_class.id == id).delete()
    close_session(session)


def delete_all_from_fk(type_class, forum_id):
    session = start_session()
    session.query(type_class).filter(type_class.forum_id == forum_id).delete()
    close_session(session)
