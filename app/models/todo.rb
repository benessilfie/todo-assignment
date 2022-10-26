class Todo < ApplicationRecord
    enum status: {
        Pending: 0,
        Completed: 1,
        Cancelled: 2
    }
end
