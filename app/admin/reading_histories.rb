ActiveAdmin.register ReadingHistory do
  permit_params :review, :words, :level, :status
  actions :all

  form title: 'A custom title' do |f|
    f.inputs do
      f.input :user_id
      f.input :book_id
      f.input :status
      f.input :review
      f.input :level
      f.input :genre
      f.input :read_at
      f.actions
    end
  end

  index do
    column :id
    column :level
    column :status
    column :pages
    column :review
    column :words
    actions
  end

  show do
    attributes_table do
      row :id
      row :level
      row :status
      row :pages
      row :review
    end
  end
end
