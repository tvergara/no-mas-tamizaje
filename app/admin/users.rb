ActiveAdmin.register User do
  permit_params :id, :email, :campus, :campus_place, :uc_member_type, :active

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

    panel 'Fill Form Intents' do
      table_for resource.scraping_intents.sort_by(&:created_at).reverse! do
        column :id
        column :state
        column :error_category
        column :created_at
        column :link do |intent|
          link_to 'link', admin_fill_screening_form_intent_path(intent.id)
        end
      end
    end
  end

  action_item only: :show do
    if params[:id]
      link_to 'Fill Screening Form', fill_form_intent_admin_user_path(resource&.id), method: :post
    end
  end

  member_action :fill_form_intent, method: :post do
    ScrapeScreeningFormJob.perform_later(resouce.id)
    redirect_to resource_path, notice: 'Filling Screening Form'
  end
end
