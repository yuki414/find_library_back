json.set! :libraries do
  json.array! @libraries do |library|
    # json.extract! library, :id, :systemid, :libid, :latitude, :longitude, :category, :libkey
    json.position do
      json.lat library.latitude
      json.lng library.longitude
    end
    json.id library.id
    json.title library.name
    json.systemid library.systemid
    json.libid library.libid
  end
end