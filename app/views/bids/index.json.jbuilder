json.array!(@bids) do |bid|
  json.extract! bid, :id, :starting_price, :current_bid, :max_bid, :end_date, :product_id, :user_id
  json.url bid_url(bid, format: :json)
end
