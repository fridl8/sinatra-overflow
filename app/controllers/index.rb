get "/" do
  redirect "/questions"
end

# TEST ROUTE FOR BUTTON
get "/button" do
  erb :"/votes/_button"
end
