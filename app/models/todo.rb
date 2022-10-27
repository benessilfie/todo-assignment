class Todo < ApplicationRecord
    belongs_to :user

    enum status: {
        Pending: 0,
        Completed: 1,
        Cancelled: 2
    }
end
