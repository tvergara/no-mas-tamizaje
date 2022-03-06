ActiveAdmin.register FillScreeningFormIntent do
  includes :user

  index do
    id_column
    column :user_email do |intent|
      intent.user.email
    end
    column :state
    column :error_category
    column :created_at
  end
end
