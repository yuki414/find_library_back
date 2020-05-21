json.set! :book do
  json.extract! @book, :id, :title, :ISBN13, :image_name, :description, :updated_at
end