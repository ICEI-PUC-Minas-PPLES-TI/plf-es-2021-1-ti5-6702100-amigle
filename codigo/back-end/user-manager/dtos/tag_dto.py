class TagDTO:
    def __init__(self, id, name, tag_category_id, is_approved):
        self.id = id
        self.name = name
        self.tag_category_id = tag_category_id
        self.is_approved = is_approved
