class OrganizationAlliance < ApplicationRecord
  belongs_to :source_organization, class_name: "Organization"
  belongs_to :target_organization, class_name: "Organization"

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  validates :source_organization_id, presence: true
  validates :target_organization_id, presence: true
  validates :target_organization_id, uniqueness: {
    scope: :source_organization_id,
    message: proc { |obj, _|
      # Verificar si existe una alianza en cualquier dirección
      if OrganizationAlliance.exists?(source_organization_id: obj.source_organization_id, target_organization_id: obj.target_organization_id, status: 'pending') ||
         OrganizationAlliance.exists?(source_organization_id: obj.target_organization_id, target_organization_id: obj.source_organization_id, status: 'pending')
        I18n.t('organization_alliances.errors.pending_alliance_exists')
      elsif OrganizationAlliance.exists?(source_organization_id: obj.source_organization_id, target_organization_id: obj.target_organization_id, status: 'accepted') ||
            OrganizationAlliance.exists?(source_organization_id: obj.target_organization_id, target_organization_id: obj.source_organization_id, status: 'accepted')
        I18n.t('organization_alliances.errors.active_alliance_exists')
      else
        I18n.t('organization_alliances.errors.alliance_exists')
      end
    }
  }
  validate :cannot_ally_with_self

  scope :pending, -> { where(status: "pending") }
  scope :accepted, -> { where(status: "accepted") }
  scope :rejected, -> { where(status: "rejected") }

  private

  def cannot_ally_with_self
    if source_organization_id == target_organization_id
      errors.add(:base, "Cannot create an alliance with yourself")
    end
  end
end
