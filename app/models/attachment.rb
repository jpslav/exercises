class Attachment < ActiveRecord::Base

  sortable

  belongs_to :parent, polymorphic: true

  validates :parent, presence: true
  validates :asset, presence: true, uniqueness: { scope: [:parent_id, :parent_type] }

  delegate_access_control_to :parent

end
