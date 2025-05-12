module TransfersHelper
  def accountable_path(accountable)
    if accountable.is_a?(Organization)
      organization_path(accountable)
    else
      user_path(accountable.user)
    end
  end

  def accounts_from_movements(transfer, with_links: false)
    transfer.movements.sort_by(&:amount).map do |movement|
      account = movement.account

      if account.accountable.blank?
        I18n.t('users.show.deleted_user')
      elsif account.accountable_type == 'Organization'
        link_to_if(with_links, account, organization_path(account.accountable))
      elsif account.accountable.active
        link_to_if(with_links, account.accountable.display_name_with_uid, user_path(account.accountable.user))
      else
        I18n.t('users.show.inactive_user')
      end
    end
  end

  # Determina si una transferencia es directamente entre bancos de tiempo
  def is_bank_to_bank_transfer?(transfer)
    return false unless transfer && transfer.movements.count == 2

    # Obtener las cuentas de origen y destino
    source_movement = transfer.movements.find_by('amount < 0')
    destination_movement = transfer.movements.find_by('amount > 0')

    return false unless source_movement && destination_movement

    # Obtener los accountables de las cuentas
    source_account = source_movement.account
    destination_account = destination_movement.account

    # Verificar si ambos son de tipo Organization
    source_account.accountable_type == 'Organization' &&
    destination_account.accountable_type == 'Organization' &&
    transfer.post.nil? # Sin post asociado, típico de transferencias directas entre bancos
  end
end
