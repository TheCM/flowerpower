json.array!(@orders) do |order|
  json.extract! order, :id, :first_name, :last_name, :email, :address, :status
  json.url order_url(order, format: :json)
end
