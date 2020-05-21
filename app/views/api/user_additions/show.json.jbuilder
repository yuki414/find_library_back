json.set! :userAddition do
  json.extract! @userAddition, :id, :uid, :address1, :address2, :address2, :address3, :latitude, :longitude
end