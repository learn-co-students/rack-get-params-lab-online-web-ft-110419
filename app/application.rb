class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty? 
        resp.write "Your cart is empty"
      else @@cart.each do |item|
        resp.write "#{item}\n"
        end
      end 
    elsif req.path.match(/add/)
      search = req.params["item"]
      resp.write add(search)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end
  
  def add(search)
    if @@items.include?(search)
      @@cart << search 
      return "added #{search}"
    else 
      return "We don't have that item"
    end
  end 

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
  
  # def cart
  #   if @@cart.empty?
  #     return "Your cart is empty"
  #   else 
  #     @@cart.each do |item|
  #     return "#{item}\n"
  #     end 
  #   end
  # end 
  
end 

