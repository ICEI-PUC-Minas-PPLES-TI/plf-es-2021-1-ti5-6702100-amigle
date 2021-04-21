class TagDTO:
    def __init__(self, id, name, categoryName, isApproved):
        self.id = id
        self.name = name
        self.isApproved = isApproved
        self.category = {
            "name": categoryName,
        }
