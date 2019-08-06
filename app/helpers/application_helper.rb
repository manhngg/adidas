module ApplicationHelper
  def permission_name(action)
    action == 'onlyread' ? '参照' : '更新'
  end

  def is_active_controller(controller_name)
    if params[:controller] == controller_name
      "active"
    else
      nil
    end
  end

  def is_active_controllers(controller_names)
    controller_names.each do |name|
      if params[:controller] == name
        return "active"
      else
        nil
      end
    end
  end

  def is_active_controller_and_action(controller_name, action_name)
    if params[:controller] == controller_name && params[:action] == action_name
      "active"
    else
      nil
    end
  end

  def is_active_controller_and_store(controller_name, store_id)
    if params[:controller] == controller_name && (params[:store_id].to_i == store_id ||
                                                  (params[:q][:store_id].to_i == store_id if params[:q]))
      "active"
    else
      nil
    end
  end
end
