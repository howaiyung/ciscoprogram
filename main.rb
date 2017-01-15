#C:\Ruby22-x64\bin -w

puts "Hello, Ruby!";

def check_int(var, num)
  raise ArgumentError, '#var is not an integer' unless num.is_a? Integer
end
class object
  @@total_clients=0
  @@vegetarian=0
  @@glutenFree=0
  @@nutFree=0
  @@fishFree=0

  def initializer(t_c, veg, g_f, n_f, f_f)

    check_int('Total number of clients ', t_c)
    check_int('Number of vegetarians ', veg)

    @@total_clients=t_c
    @@vegetarian=veg
    @@glutenFree=g_f
    @@nutFree=n_f
    @@fishFree=f_f
  end
end

restaurant_1=object(4,5,6,7,8)
