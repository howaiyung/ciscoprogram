#C:\Ruby22-x64\bin -w



def input_check(hashname, objecthash, object)

  object_string = object.to_s

  if object_string =~ /^[0-9]*$/ && !(object.nil?) #&& !(object_string.empty?)
    if objecthash == "rest_rating"
      if object.to_i <= 5
        temp_num = object.to_i
      else
        raise ArgumentError.new("Improper input for " + hashname + ", attribute "+ objecthash)
      end
    end

    temp_num = object.to_i
  else
    raise ArgumentError.new("Improper input for " + hashname + ", attribute "+ objecthash)
  end


  return temp_num


end


def check_meal(name, t_c, veg, g_f, n_f, f_f)
  input_check("Order meal", "Total_meals", t_c)
  input_check("Order meal", "vegetarian", veg)
  input_check("Order meal", "gluten_free", g_f)
  input_check("Order meal", "nut_free", n_f)
  input_check("Order meal", "fish_free", f_f)

  raise ArgumentError.new("The total amount of meals is less than the amount of specialized meals been ordered. Please retype your order again.") if (t_c<(veg+g_f+n_f+f_f))
end




class Meal_order
  attr_accessor :total_meals, :vegetarian, :gluten_free, :nut_free, :fish_free



  def self.get_info(first_msg, error_msg)
    temp_num = 0
    temp = 0

    loop do
      if temp == 0
        print first_msg
        temp = temp+1
      else
        print error_msg
      end

      temp_num = gets
      temp_num_string = temp_num.to_s.delete!("\n")

      break if temp_num_string =~ /^[0-9]*$/ && !(temp_num.nil?) && !(temp_num_string.empty?)
    end

    temp_num_int = temp_num.to_i

    return temp_num_int
  end

  def self.new_using_order_meals()
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

    self.new(t_c, veg, g_f, n_f, f_f)

  end



  def initialize(t_c, veg, g_f, n_f, f_f)

      check_meal("Order meal", t_c, veg, g_f, n_f, f_f)

      @total_meals, @vegetarian, @gluten_free, @nut_free, @fish_free = t_c, veg, g_f, n_f, f_f

  end

  def inspect
    "#@total_meals #@vegetarian #@gluten_free #@nut_free #@fish_free"
  end

end

class Restaurant < Meal_order
  attr_accessor :rest_name, :rest_rating

  def initialize(name, rating, t_c, veg, g_f, n_f, f_f)

    check_meal(name, t_c, veg, g_f, n_f, f_f)

    super(t_c, veg, g_f, n_f, f_f)
    @rest_name=name
    @rest_rating=rating
  end

end


class Restaurants

  attr_accessor :rests

  def sort_by(sort_type)

    temp_rests = 0


    if @rests.any?  # Check if there is any entries in the restaurants array
      rests.each do |rest| # Go through each entry in the array
        if rest.instance_of? Restaurant #Check if the resturant is an instance of Restaurant
          # Check if each value in the
          input_check(rest.rest_name, "rest_rating", rest.rest_rating)
          check_meal(rest.rest_name, rest.total_meals, rest.vegetarian, rest.gluten_free, rest.nut_free, rest.fish_free)

        else
          raise ArgumentError.new("Invalid restaurant entry")
        end

      end
      rest = @rests.first

      if rest.respond_to? (sort_type)
        case sort_type
        when 'rest_name'
          temp_rests = @rests.sort_by { |a| a.rest_name}
        when 'rest_rating'
          temp_rests = @rests.sort_by { |a| [-a.rest_rating, a.rest_name] }
        when 'total_meals'
          temp_rests = @rests.sort_by { |a| [-a.total_meals, a.rest_name] }
        when 'vegetarian'
          temp_rests = @rests.sort_by { |a| [-a.vegetarian, a.rest_name] }
        when 'gluten_free'
          temp_rests = @rests.sort_by { |a| [-a.gluten_free, a.rest_name] }
        when 'nut_free'
          temp_rests = @rests.sort_by { |a| [-a.nut_free, a.rest_name] }
        when 'fish_free'
          temp_rests = @rests.sort_by { |a| [-a.fish_free, a.rest_name] }
        else
          raise ArgumentError.new("Attribute does not exist for a restaurant")
        end
      else
        raise ArgumentError.new("Attribute does not exist for a restaurant")
      end
    else
      raise ArgumentError.new("No restaurants entered into the database")
    end

    return temp_rests
  end

  def get_part_meal_order(meal_attr, meal_type, rest_order, team_order, rest)

    if(team_order.send(meal_attr) -  rest.send(meal_attr) < 0)
      rest.total_meals -= team_order.send(meal_attr)
      rest_order.push(team_order.send(meal_attr))
      team_order.total_meals -= team_order.send(meal_attr)
      team_order.send(meal_type, 0)
    else
      rest_order.push(rest.send(meal_attr))
      team_order.send(meal_type, team_order.send(meal_attr)-rest.send(meal_attr))
      rest.total_meals -= rest.send(meal_attr)
      team_order.total_meals -= rest.send(meal_attr)
    end
  end

  def get_rest_order(team_order)

    temp_rest_meals = Array.new


    rests_sort = sort_by('rest_rating')

    check_meal("Order meal", team_order.total_meals, team_order.vegetarian, team_order.gluten_free, team_order.nut_free, team_order.fish_free)

    rests_sort.each do |rest|
    #  temp_rest_meals = rest.instance_variables.map{|var| print rest.instance_variable_get(var)}
      temp_order_rest = Array.new

      temp_order_rest.push(rest.rest_name)

      get_part_meal_order(:vegetarian, "vegetarian=", temp_order_rest, team_order, rest)
      if team_order.total_meals == 0
        temp_rest_meals.push(temp_order_rest)
        break
      end

      get_part_meal_order(:gluten_free, "gluten_free=", temp_order_rest, team_order, rest)
      if team_order.total_meals == 0
        temp_rest_meals.push(temp_order_rest)
        break
      end

      get_part_meal_order(:nut_free, "nut_free=", temp_order_rest, team_order, rest)
      if team_order.total_meals == 0
        temp_rest_meals.push(temp_order_rest)
        break
      end

      get_part_meal_order(:fish_free, "fish_free=", temp_order_rest, team_order, rest)
      if team_order.total_meals == 0
        temp_rest_meals.push(temp_order_rest)
        break
      end

      get_part_meal_order(:total_meals, "total_meals=", temp_order_rest, team_order, rest)
      if team_order.total_meals == 0
        temp_rest_meals.push(temp_order_rest)
        break
      end

      temp_rest_meals.push(temp_order_rest)

      puts team_order.inspect

    end

    puts "#{temp_rest_meals}"
  end



  def initialize
    @rests = Array.new
  end





# Delete restaurants that don't have specific meals that is required from the


end












class Main

  #puts "Welcome to my restaurant customizer"

  #order_team = Meal_order.new_using_order_meals

  #restaurants = Restaurants.new

  #restaurants.rests.push(Restaurant.new("Phillips",5,2.5,0.1,0.1,0.1,0.1))

  #restaurants.rests.push(Restaurant.new("Phillips",5,nil,nil,nil,nil,nil))

  #restaurants.rests.push(Restaurant.new("Phillips",5,0x90,0x26,0x10,0x10,0x10))





  restaurants = Restaurants.new

  #restaurants.rests.push(Restaurant.new("Phillips",5,{total_meals: 40, vegetarian: 5, gluten_free: 2, nut_free: 2, fish_free: 2}))
  #restaurants.rests.push(Restaurant.new("Chicken LaFlay",4,{total_meals: 20, gluten_free: 1, nut_free: 1, fish_free: 1}))

  restaurants.rests.push(Restaurant.new("Chicken",4,5,1,1,1,1))
  restaurants.rests.push(Restaurant.new("Phillips",5,9,1,1,1,2))

  restaurants.get_rest_order(Meal_order.new(11,1,1,1,1))

  #restaurants.sort_by(:vegetarian)

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
