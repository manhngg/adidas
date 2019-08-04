class InspectionError < ApplicationRecord
  belongs_to :store

  enum error_type: { no_record: 1, not_registered: 2, no_order: 3 }
end
