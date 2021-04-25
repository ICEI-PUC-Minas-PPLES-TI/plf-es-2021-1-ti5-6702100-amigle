def user_dto(user_object):
    tags = []
    for tag in user_object.tags:
        tags.append(tag_dto(tag))

    dict_format = {
        "id": user_object.id,
        "name": user_object.name,
        "birthDate": str(user_object.birth_date),
        "isAdmin": user_object.is_admin,
        "profilePic": user_object.profile_pic,
        "tags": tags
    }
    return dict_format


def tag_dto(tag_object):
    dict_format = {
        "id": tag_object.id,
        "name": tag_object.name,
        "isApproved": tag_object.is_approved,
        "category": {
            "id": tag_object.tag_category.id,
            "name": tag_object.tag_category.name
        }
    }
    return dict_format


def category_dto(category_object):
    dict_format = {
        "id": category_object.id,
        "name": category_object.name,
    }
    return dict_format
