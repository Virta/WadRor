json.array!(@ratings) do |r|
    json.extract! r, :id, :score, :beer
end