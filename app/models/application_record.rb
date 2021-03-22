class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  enum statuses: [:active, :canceled]
end
