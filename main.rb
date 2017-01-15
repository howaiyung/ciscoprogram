#C:\Ruby22-x64\bin -w





class Team_Order
  @@total_clients=0
  @@vegetarian=0
  @@glutenFree=0
  @@nutFree=0
  @@fishFree=0
  @@allergyFree=0

  def initializer(t_c, veg, g_f, n_f, f_f)

    @@total_clients=t_c
    @@vegetarian=veg
    @@glutenFree=g_f
    @@nutFree=n_f
    @@fishFree=f_f
    @@allergyFree=t_c-(veg+g_f+n_f+f_f)

  end
end

class Rest_Stats
  @@total_clients=0
  @@vegetarian=0
  @@glutenFree=0
  @@nutFree=0
  @@fishFree=0

  def initializer(t_c, veg, g_f, n_f, f_f)
    @@total_clients=t_c
    @@vegetarian=veg
    @@glutenFree=g_f
    @@nutFree=n_f
    @@fishFree=f_f
  end
end


class Main

  @@t_c=0
  @@veg=0
  @@g_f=0
  @@n_f=0
  @@f_f=0

  puts "Welcome to my restaurant customizer"

  # Create a function for this input
  # Create another function for error checking ints

  puts "How many meals are we ordering for the team?: "
  @@t_c = Integer(gets) rescue nil

  until @@t_c != nil do
    puts "Invalid input, please retype the number of meals been ordered: "
    @@t_c = Integer(gets) rescue nil
  end

  puts "How many meals of those meals are vegetarian?: "
  @@veg = Integer(gets) rescue nil

  until @@veg != nil do
    puts "Invalid input, please retype the number of vegetarian meals been ordered: "
    @@veg = Integer(gets) rescue nil
  end

  puts "How many meals of those meals are gluten free?: "
  @@g_f = Integer(gets) rescue nil

  until @@g_f != nil do
    puts "Invalid input, please retype the number of gluten free meals been ordered: "
    @@g_f = Integer(gets) rescue nil
  end

  puts "How many meals of those meals are nut free?: "
  @@n_f = Integer(gets) rescue nil

  until @@n_f != nil do
    puts "Invalid input, please retype the number of nut free meals been ordered: "
    @@n_f = Integer(gets) rescue nil
  end

  puts "How many meals of those meals are fish free?: "
  @@f_f = Integer(gets) rescue nil

  until @@f_f != nil do
    puts "Invalid input, please retype the number of fish free meals been ordered: "
    @@f_f = Integer(gets) rescue nil
  end

  #Error checking if the total number of gluten, nut, vegetarian, fish > Total meals

  order_team = Team_Order. new
  order_team.initializer(@@t_c, @@veg, @@g_f, @@n_f, @@f_f)

  # Algorithm, find which sub group is the biggest from the order
  # Select the 1st restaurant base upon the closest amount that can handle the number of meals


end



Main
