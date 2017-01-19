#C:\Ruby22-x64\bin -w



def input_check(hashname, objecthash, object)

  object_string = object.to_s

  if object_string =~ /^[0-9]*$/ && !(object.nil?)
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

# Common function used by all classes to check if the data entered in
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

    input_check("Restaurant", "rest_rating", rating)

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
        if rest.instance_of? Restaurant #Check if the restaurant is an instance of Restaurant
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

  def get_part_meal_order(meal_attr, meal_type, rest_order, team_order, rest, rests_meals)

    if (rest_order.instance_of? Array) && (team_order.instance_of? Meal_order) &&
       (rest.instance_of? Restaurant) && (rests_meals.instance_of? Array)  &&
        (meal_type.instance_of? String) && (team_order.respond_to?(meal_attr))
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

      if team_order.total_meals == 0
        rests_meals.push(rest_order)
      end
    else
      raise ArgumentError.new("Invalid data")
    end


  end

  def get_rest_order(team_order)

    temp_rest_meals = Array.new

    rests_sort = sort_by('rest_rating')

    check_meal("Order meal", team_order.total_meals, team_order.vegetarian, team_order.gluten_free, team_order.nut_free, team_order.fish_free)

    rests_sort.each do |rest|

      temp_order_rest = Array.new

      temp_order_rest.push(rest.rest_name)
      get_part_meal_order(:vegetarian, "vegetarian=", temp_order_rest, team_order, rest, temp_rest_meals)
      break if team_order.total_meals == 0

      get_part_meal_order(:gluten_free, "gluten_free=", temp_order_rest, team_order, rest, temp_rest_meals)
      break if team_order.total_meals == 0

      get_part_meal_order(:nut_free, "nut_free=", temp_order_rest, team_order, rest, temp_rest_meals)
      break if team_order.total_meals == 0

      get_part_meal_order(:fish_free, "fish_free=", temp_order_rest, team_order, rest, temp_rest_meals)
      break if team_order.total_meals == 0

      get_part_meal_order(:total_meals, "total_meals=", temp_order_rest, team_order, rest, temp_rest_meals)
      break if team_order.total_meals == 0

      temp_rest_meals.push(temp_order_rest)

    end

    if team_order.total_meals == 0
      print "Expected meal order:"
      temp_rest_meals.each do |order_rest|
        print " #{order_rest[0]} "
        print "( #{order_rest[1] if order_rest[1] != 0 }#{" vegetarian + " if order_rest[1] != 0 }"
        print "#{order_rest[2] if order_rest[2] != 0 }#{" gluten-free + " if order_rest[2] != 0 }"
        print "#{order_rest[3] if order_rest[3] != 0 }#{" nut-free + " if order_rest[3] != 0 }"
        print "#{order_rest[4] if order_rest[4] != 0 }#{" fish-free + " if order_rest[4] != 0 }"
        print "#{order_rest[5] if order_rest[5] != 0 }#{" others" if order_rest[5] != 0 } ), "
      end
    else
      total_other = team_order.total_meals - (team_order.vegetarian + team_order.gluten_free + team_order.nut_free + team_order.fish_free)

      print "Unfortunately, we cannot fulfill the order, "
      print "There are #{team_order.total_meals} meals that cannot be filled "
      print "(#{team_order.vegetarian if team_order.vegetarian != 0}#{" vegetarian," if team_order.vegetarian != 0 }"
      print " #{team_order.gluten_free if team_order.gluten_free != 0}#{" gluten_free," if team_order.gluten_free != 0 }"
      print " #{team_order.nut_free if team_order.nut_free != 0}#{" nut_free," if team_order.nut_free != 0 }"
      print " #{team_order.fish_free if team_order.fish_free != 0}#{" fish_free," if team_order.fish_free != 0 }"
      puts " #{total_other if total_other != 0}#{" other )" if total_other != 0 }"

      print "Close meal order:"
      temp_rest_meals.each do |order_rest|
        print " #{order_rest[0]} "
        print "( #{order_rest[1] if order_rest[1] != 0 }#{" vegetarian + " if order_rest[1] != 0 }"
        print "#{order_rest[2] if order_rest[2] != 0 }#{" gluten-free + " if order_rest[2] != 0 }"
        print "#{order_rest[3] if order_rest[3] != 0 }#{" nut-free + " if order_rest[3] != 0 }"
        print "#{order_rest[4] if order_rest[4] != 0 }#{" fish-free + " if order_rest[4] != 0 }"
        print "#{order_rest[5] if order_rest[5] != 0 }#{" others" if order_rest[5] != 0 } ), "
      end

    end

  end



  def initialize
    @rests = Array.new
  end
end












class Main

  puts "Welcome to my restaurant customizer"

  new_team_order = Meal_order.new_using_order_meals()

  restaurants = Restaurants.new

  restaurants.rests.push(Restaurant.new("Chicken",4,2,0,0,0,1))
  restaurants.rests.push(Restaurant.new("Phillips",5,3,1,0,1,0))

  restaurants.get_rest_order(new_team_order)


  #restaurants.get_rest_order(Meal_order.new(11,1,1,1,2))

end





#Improvements later on, add additional varaible called other which is total meals minus all the specialty meals


Main
