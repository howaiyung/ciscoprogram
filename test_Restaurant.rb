
# File: main.rb

require_relative "main"

require "test/unit"

class Test_Restaurant < Test::Unit::TestCase

  def test_Restaurant_initializer_normal
    assert_nothing_raised( RuntimeError ){Restaurant.new("Thomas",5,20,2,2,2,2)}
  end

  def test_Restaurant_initializer_total_meals_smaller
    assert_raise( ArgumentError ){Restaurant.new("Thomas", 5,5,2,2,2,2)}
  end

  def test_Restaurant_initializer_missing_var
    assert_raise( ArgumentError ){Restaurant.new("Thomas",5,20,2,2,2)}
  end

  def test_Restaurant_initializer_all_nil
    assert_raise( ArgumentError ){Restaurant.new(nil,nil,nil,nil,nil,nil,nil)}
  end

  def test_Restaurant_initializer_all_floats
    assert_raise( ArgumentError ){Restaurant.new(2.6,0.3,2.5,0.1,0.1,0.1,0.1)}
  end

  def test_Restaurant_initializer_all_float_chars
    assert_raise( ArgumentError ){Restaurant.new('4.5','5.0','2.5','0.1','0.1','0.1','0.1')}
  end

  def test_Restaurant_initializer_all_int_chars
    assert_raise( ArgumentError ){Restaurant.new('6','5','10','1','1','1','2')}
  end

  def test_Restaurant_initializer_all_chars
    assert_raise( ArgumentError ){Restaurant.new('T','T','C','H','A','I','R')}
  end

  def test_Restaurant_initializer_all_strings
    assert_raise( ArgumentError ){Restaurant.new("Thomas","seen","See","the","world","as","you")}
  end

  def test_Restaurant_initializer_all_equations_integers
    assert_raise( ArgumentError ){Restaurant.new((39/3),(25/5),(4/2),((4*8)/2),(((9/3)*2)+3),((24*4)/6),(65/5))}
  end

  def test_Restaurant_initializer_all_equations_integers_strings
    assert_raise( ArgumentError ){Restaurant.new("((8*6)/42)","(9/3)*4","(4/2)","((4*8)/2)","(((9/3)*2)+3)","((24*4)/6)","(65/5)")}
  end

  # Can not stop the conversion from automatically from hex to an integer,
  # a primitive conversion. Built into Ruby.
  def test_Restaurant_initializer_all_hex_integer
    assert_raise( ArgumentError ){Restaurant.new(0x9621,0x05,0x90,0x26,0x10,0x10,0x10)}
  end

  def test_Restaurant_initializer_all_hex_nils
    assert_raise( ArgumentError ){Restaurant.new(0xf0a1,0xf0a1,0xf0a1,0xf0a1,0xf0a1,0xf0a1,0xf0a1)}
  end

  def test_Restaurant_initializer_max_value
    n_BYTES = [100].pack('i').size
    n_BITS = n_BYTES * 16
    max = 2 ** (n_BITS - 2) - 1
    mIN = -max - 1
    assert_nothing_raised( ArgumentError ){Restaurant.new("Thomas",5,max,1,1,1,1)}
  end

  def test_Restaurant_initializer_empty
    assert_raise( ArgumentError ){Restaurant.new('\n','\n','\n','\n','\n','\n','\n')}
  end

  def test_Restaurant_initializer_higher_rating
      assert_raise( ArgumentError ){Restaurant.new("Thomas",10,5,1,1,1,1)}
  end
end
