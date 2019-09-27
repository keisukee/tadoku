ActiveAdmin.register Book do
  permit_params :title, :words, :isbn, :asin, :pages, :url, :start_at, :price
  actions :all

  index do
    column :id
    column :isbn
    column :asin
    column :pages
    column :title
    column :words
    column :url
    column :price
    actions
  end

  show do
    attributes_table do
      row :id
      row :isbn
      row :asin
      row :pages
      row :title
      row :start_at
      row :created_at
      row :updated_at
      row :deleted_at
      row :confirmed_at
      row :confirmation_sent_at
      row :url
      row :price
    end
  end
end
