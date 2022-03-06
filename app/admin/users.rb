ActiveAdmin.register User do
  permit_params :id, :email

  index do
    id_column
    column :email
    column :active
    column :campus
    column :campus_place
    column :uc_member_type
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :active
      f.input :campus
      f.input :campus_place
      f.input :uc_member_type
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :active
      row :campus
      row :campus_place
      row :uc_member_type
      row :scraping_days do
        |user| user.scraping_days.map(&:weekday)
      end
    end
  end
end
