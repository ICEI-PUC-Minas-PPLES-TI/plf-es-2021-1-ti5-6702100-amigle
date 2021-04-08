from conf import dao_postgre
from dtos.user_dto import UserDTO
from models.user import User


def insert(body):
    user = User("teste", body["name"], body["age"], body["isAdmin"])
    # user.create_firebase_user(body["email"], body["password"])
    dao_postgre.insert(user)


def get_all():
    users = dao_postgre.get_all(User)
    return format_json(users)


def get(id):
    user = dao_postgre.get(User, id)
    user = user.__dict__
    return UserDTO(user['id'], user['name'], user['age'], user['is_admin'], user['email']).__dict__


def update(id, body):
    s = dao_postgre.start_session()

    s.query(User).filter(User.id == id).update({
        'name': body["name"],
        'age': body["age"],
        'email': body["email"],
        'is_admin': body["is_admin"]
    })
    dao_postgre.close_session(s)


def delete(id):
    dao_postgre.delete(User, id)


def format_json(users):
    users_json = []

    for user in users:
        user = user.__dict__
        users_json.append(
            UserDTO(user['id'], user['name'], user['age'], user['email'], user['is_admin']).__dict__)
    return users_json
