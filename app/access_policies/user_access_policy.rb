class UserAccessPolicy
  # Contains all the rules for which requestors can do what with which User objects.

  def self.action_allowed?(action, requestor, user)
    case action
    when :search
      !requestor.is_human? || !requestor.is_anonymous?
    when :create
      false
    when :read, :update, :destroy
      requestor.is_human? && !requestor.is_anonymous?
    else
      false
    end
  end

end
