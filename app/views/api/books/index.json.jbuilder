json.set! :books do
  json.array! @books do |book|
    json.extract! book, :id, :title, :image_name,:updated_at
  end
end