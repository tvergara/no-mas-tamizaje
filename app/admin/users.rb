ActiveAdmin.register User do
  permit_params :id, :email

  index do
    id_column
    column :email
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
    end
    f.actions
  end
end
