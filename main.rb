#C:\Ruby22-x64\bin -w


class Meal_order
  attr_accessor :total_meals
end

class Restaurant
  attr_accessor :rest_name, :rest_rating, :meals_served

  def initialize(name, rating, attributes)
    @rest_name=name
    @rest_rating=rating
    @meals_served=attributes
  end

end


class Restaurants

  attr_accessor :rests

  def initialize
    @rests = Array.new
  end

  def sort_by(sort_type)
    for rest in @rests
      if rest.meals_served.has_attribute?(sort_type)
        puts "True"
      end
    end

  end


# Delete restaurants that don't have specific meals that is required from the 


end






def get_info(first_msg, error_msg)
  temp_num = 0

  print first_msg
  temp_num = Integer(gets).to_i rescue nil

  until temp_num != nil and temp_num > 0
    print error_msg
    temp_num = Integer(gets) rescue nil
  end

  return temp_num

end

def get_meals()
  t_c=0
  veg=0
  g_f=0
  n_f=0
  f_f=0

  begin
    t_c = get_info("How many meals are we ordering for the team?: ", "Invalid input, please retype the number of meals been ordered: ")
    veg = get_info("How many meals of those meals are vegetarian?: ", "Invalid input, please retype the number of vegetarian meals been ordered: ")
    g_f = get_info("How many meals of those meals are gluten free?: ", "Invalid input, please retype the number of gluten free meals been ordered: ")
    n_f = get_info("How many meals of those meals are nut free?: ", "Invalid input, please retype the number of nut free meals been ordered: ")
    f_f = get_info("How many meals of those meals are fish free?: ", "Invalid input, please retype the number of fish free meals been ordered: ")


    puts "The total amount of meals is less than the amount of specialized meals been ordered. Please retype your order again." if (t_c<(veg+g_f+n_f+f_f))

  end until ((veg+g_f+n_f+f_f) <= t_c)

  order_team = Meal_order.new
  order_team.total_meals = t_c

  if veg > 0
    order_team.class.module_eval {attr_accessor :vegetarian}
    order_team.vegetarian = veg
  end

  if g_f > 0
    order_team.class.module_eval {attr_accessor :gluten_free}
    order_team.gluten_free = g_f
  end

  if n_f > 0
    order_team.class.module_eval {attr_accessor :nut_free}
    order_team.nut_free = n_f
  end

  if f_f > 0
    order_team.class.module_eval {attr_accessor :fish_free}
    order_team.fish_free = f_f
  end

  return order_team
end




class Main

  puts "Welcome to my restaurant customizer"

  order_team = get_meals()

  restaurants = Restaurants.new

  restaurants.rests.push(Restaurant.new("Phillips",5,{total_meals: 40, vegetarian: 5, gluten_free: 2, nut_free: 2, fish_free: 2}))
  restaurants.rests.push(Restaurant.new("Chicken LaFlay",4,{total_meals: 20, gluten_free: 1, nut_free: 1, fish_free: 1}))

  restaurants.sort_by("vegetarian")
  #Error checking if the total number of gluten, nut, vegetarian, fish > Total meals



  #puts order_team.t_c


  # Algorithm, find which sub group is the biggest from the order
  # Select the 1st restaurant base upon the closest amount that can handle the number of meals
  #
  # Generate a bunch of restaurants using a random name and number generator function
  # about a 100 restaurants

  # Another function handles the selection

  # display results

end







Main
