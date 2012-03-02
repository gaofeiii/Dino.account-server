ActiveAdmin.register Account do
  
  index do
    column :id
    column :email
    default_actions
  end
  
  filter :id
  filter :email
  
  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
  
  show :title => :email do
    attributes_table do
      row :id
      row :email
    end
    active_admin_comments
  end
end
