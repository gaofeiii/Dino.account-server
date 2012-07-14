ActiveAdmin.register Account do
  
  index do
    column :id
    column :username
    column :email
    default_actions
  end
  
  filter :id
  filter :username
  filter :email
  
  form do |f|
    f.inputs "Details" do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
  
  show :title => :email do
    attributes_table do
      row :id
      row :username
      row :email
    end
    active_admin_comments
  end
end
