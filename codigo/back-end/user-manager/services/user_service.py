from conf.dao_postgre import start_session, close_session
from models.user import User


def insert(body):
    user = User(None, body["name"], body["age"], body["email"], body["is_admin"])
    user.create_firebase_user(body["email"], body["email"])
    insert(user)


def get_all():
    users = get_all(User)
    return format_json(users)


def get(id):
    user = get(User, id)
    user = user.__dict__
    return UserDTO(user['id'], user['name'], user['age'], user['is_admin'], user['email']).__dict__


def update(id, body):
    s = start_session()

    s.query(User).filter(User.id == id).update({
        'name': body["name"],
        'age': body["age"],
        'email': body["email"],
        'is_admin': body["is_admin"]
    })
    close_session(s)


def delete(id):
    delete(User, id)


def format_json(users):
    users_json = []

    for user in users:
        user = user.__dict__
        users_json.append(
            UserDTO(user['id'], user['name'], user['age'], user['email'], user['is_admin']).__dict__)
    return users_json
