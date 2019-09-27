ActiveAdmin.register User do

  permit_params :email, :words, :name, :start_at
  actions :all

  index do
    column :id
    column :name
    column :email
    column :words
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :start_at
      row :created_at
      row :updated_at
      row :deleted_at
      row :confirmed_at
      row :confirmation_sent_at
    end
  end
end
