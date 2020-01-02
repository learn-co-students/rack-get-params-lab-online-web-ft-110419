require 'pry'
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
 
    if req.path.match(/items/) # if req.path matches /items/
      @@items.each do |item| #iterate over each item, and it writes items
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"] # variable is equal to req.params method which takes in an argument.
      resp.write handle_search(search_term) 

    elsif req.path.match(/cart/)
      if @@cart.empty?
      resp.write "Your cart is empty"
      else
        @@cart.each do |item| #else we will iterate over what we have in the cart currently.
          resp.write "#{item}\n"
        end
      end

    elsif req.path.match(/add/) #we can have multiple if statements as long as they have an end to separate them.
      new_item = req.params["item"] # in the spec you will see "get '/add?item=Figs'"
      if @@items.include?(new_item) # if the items array includes the item
      @@cart << new_item # we add that new item to the cart.
      resp.write "added #{new_item}" #we write "added (interpolation)"
      else
        resp.write "We don't have that item"
      end
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "We don't have that item"
    end
  end
end

# https://sailsjs.com/documentation/reference/request-req/req-params