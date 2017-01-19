



require "test/unit"


class Test_Restaurants < Test::Unit::TestCase

  # Testing the sort_by function

  def setup
    @@arrayrests = Restaurants.new

    @@arrayrests.rests.push(Restaurant.new("Chicken",4,2,0,0,0,1))
    @@arrayrests.rests.push(Restaurant.new("Phillips",5,3,1,0,1,0))
  end

  def sort_by_normal
    assert_nothing_raised( RuntimeError ){@@arrayrests.sort_by('rest_rating')}
  end

  # Testing the get_part_meal_order function


  # Testing the get_rest_order function
end
