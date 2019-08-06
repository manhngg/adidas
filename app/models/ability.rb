class Ability
  include CanCan::Ability

  def initialize(admin)
    admin ||= Admin.new
    # if admin.system_admin
    #   can :manage, :all
    # end
    cannot :destroy, Admin, :system_admin => true

    alias_action :create, :update, :destroy, :to => :cud

    # Define ability for Admin manage stores
    admin.stores.each do |store|
      if AdminManageStore.where(admin_id: admin.id, store_id: store.id, action: "update").any?
        can :update, Store, id: store.id
        can :read, Store, id: store.id
      end
      if AdminManageStore.where(admin_id: admin.id, store_id: store.id, action: "onlyread").any?
        can :read, Store, id: store.id
      end
    end

    # Define ability for Admin manage features
    admin.permissions.each do |permission|
      action = permission.action
      klass = permission.klass.constantize

      if action.include?("manage")
        can :manage, klass
      end

      if action.include?("onlyread")
        can :read, klass
        if klass == MessageGroup
          can :read, TransceiverGroup
        end
        if klass == Adrsbook
          can :read, AdrsbookSubcategory
        end
        if klass == Order
          can :read, OrderItem
        end
      end
      if action.include?("update")
        can :cud, klass
        can :import, klass
        can :csv_import, klass
        if klass == MessageGroup
          can :cud, TransceiverGroup
        end
        if klass == Adrsbook
          can :cud, AdrsbookSubcategory
        end
        if klass == Order
          can :cud, OrderItem
        end
      end
    end

    # admin.permissions.as_json.group_by {|x| x['klass']}.each do |klass, records|
    #   can :manage, klass.constantize if records.pluck('action').include?('manage')

    #   if records.pluck('action').include?('onlyread')
    #     can :read, klass.constantize
    #     can :export_csv, klass.constantize
    #   end

    #   if records.pluck('action').include?('update')
    #     # can :cud, klass.constantize
    #     can :create, klass.constantize
    #     can :update, klass.constantize
    #     can :delete, klass.constantize
    #     can :import_csv, klass.constantize
    #   end

    #   case klass
    #   when 'RecordReport'
    #     if records.pluck('action').include?('onlyread')
    #       can :read, WorkingRecord
    #     end

    #     if records.pluck('action').include?('update')
    #       # can :cud, klass.constantize
    #       can :create, WorkingRecord
    #       can :update, WorkingRecord
    #       can :delete, WorkingRecord
    #       can :export_csv, WorkingRecord
    #     end
    #   when 'MessageGroup'
    #     if records.pluck('action').include?('onlyread')
    #       can :read, TransceiverGroup
    #     end

    #     if records.pluck('action').include?('update')
    #       # can :cud, klass.constantize
    #       can :create, TransceiverGroup
    #       can :update, TransceiverGroup
    #       can :delete, TransceiverGroup
    #       can :export_csv, TransceiverGroup
    #       end
    #   when 'Adrsbook'
    #   if records.pluck('action').include?('onlyread')
    #     can :read, AdrsbookSubcategory
    #   end

    #   if records.pluck('action').include?('update')
    #     # can :cud, klass.constantize
    #     can :create, AdrsbookSubcategory
    #     can :update, AdrsbookSubcategory
    #     can :delete, AdrsbookSubcategory
    #     can :export_csv, AdrsbookSubcategory
    #   end
    #   when 'Inspection'
    #     if records.pluck('action').include?('onlyread')
    #       can :read, InspectionError
    #     end

    #     if records.pluck('action').include?('update')
    #       # can :cud, klass.constantize
    #       can :create, AdrsbookSubcategory
    #       can :update, AdrsbookSubcategory
    #       can :delete, AdrsbookSubcategory
    #       can :export_csv, AdrsbookSubcategory
    #     end





    #   when 'Inspection'
    #     if records.pluck('action').include?('onlyread')
    #       can :read, AdrsbookSubcategory
    #     end

    #     if records.pluck('action').include?('update')
    #       # can :cud, klass.constantize
    #       can :create, AdrsbookSubcategory
    #       can :update, AdrsbookSubcategory
    #       can :delete, AdrsbookSubcategory
    #       can :export_csv, AdrsbookSubcategory
    #     end




    #   when 'Inspection'
    #     if records.pluck('action').include?('onlyread')
    #       can :read, AdrsbookSubcategory
    #     end

    #     if records.pluck('action').include?('update')
    #       # can :cud, klass.constantize
    #       can :create, AdrsbookSubcategory
    #       can :update, AdrsbookSubcategory
    #       can :delete, AdrsbookSubcategory
    #       can :export_csv, AdrsbookSubcategory
    #     end





    #   when 'Inspection'
    #     if records.pluck('action').include?('onlyread')
    #       can :read, AdrsbookSubcategory
    #     end

    #     if records.pluck('action').include?('update')
    #       # can :cud, klass.constantize
    #       can :create, AdrsbookSubcategory
    #       can :update, AdrsbookSubcategory
    #       can :delete, AdrsbookSubcategory
    #       can :export_csv, AdrsbookSubcategory
    #     end



    #   when 'Inspection'
    #     if records.pluck('action').include?('onlyread')
    #       can :read, AdrsbookSubcategory
    #     end

    #     if records.pluck('action').include?('update')
    #       # can :cud, klass.constantize
    #       can :create, AdrsbookSubcategory
    #       can :update, AdrsbookSubcategory
    #       can :delete, AdrsbookSubcategory
    #       can :export_csv, AdrsbookSubcategory
    #     end


    #   when 'Inspection'
    #     if records.pluck('action').include?('onlyread')
    #       can :read, OrderItem
    #     end

    #     if records.pluck('action').include?('update')
    #       # can :curd, klass.constantize
    #       can :create, OrderItem
    #       can :update, OrderItem
    #       can :delete, OrderItem
    #       can :export_csv, OrderItem
    #     end
    #   when 'Product'
    #     if records.pluck('action').include?('onlyread')

    #     end
    #     if records.pluck('action').include?('update')

    #     end
    #   else

    #   end
    # end
  end
end
