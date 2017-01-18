# File: main.rb

require_relative "main"
require "test/unit"

class Test_Meal_order_ordinary_order < Test::Unit::TestCase

<<-DOC
  def setup
    order_meals = Meal_order.new(20, 2, 2, 2, 2)
  end

  def test_get_info_string_messages
    assert_nothing_raised( RuntimeError ){Meal_order.get_info("This is a good sign", "This is a bad sign") }
  end

  def test_get_info_char_messages
    assert_nothing_raised( RuntimeError ){Meal_order.get_info('c', 'v') }
  end
DOC



  def test_Meal_order_initializer_normal
    assert_nothing_raised( RuntimeError ){Meal_order.new(20,2,2,2,2)}
  end

  def test_Meal_order_initializer_total_meals_smaller
    assert_raise( ArgumentError ){Meal_order.new(5,2,2,2,2)}
  end

  def test_Meal_order_initializer_missing_var
    assert_raise( ArgumentError ){Meal_order.new(20,2,2,2)}
  end

  def test_Meal_order_initializer_all_nil
    assert_raise( ArgumentError ){Meal_order.new(nil,nil,nil,nil,nil)}
  end

  def test_Meal_order_initializer_all_floats
    assert_raise( ArgumentError ){Meal_order.new(2.5,0.1,0.1,0.1,0.1)}
  end

  def test_Meal_order_initializer_all_float_chars
    assert_raise( ArgumentError ){Meal_order.new('2.5','0.1','0.1','0.1','0.1')}
  end

  def test_Meal_order_initializer_all_int_chars
    assert_raise( ArgumentError ){Meal_order.new('10','1','1','1','2')}
  end

  def test_Meal_order_initializer_all_chars
    assert_raise( ArgumentError ){Meal_order.new('C','H','A','I','R')}
  end

  def test_Meal_order_initializer_all_strings
    assert_raise( ArgumentError ){Meal_order.new("See","the","world","as","you")}
  end

  def test_Meal_order_initializer_all_equations_integers
    assert_raise( ArgumentError ){Meal_order.new((4/2),((4*8)/2),(((9/3)*2)+3),((24*4)/6),(65/5))}
  end

  def test_Meal_order_initializer_all_equations_integers_strings
    assert_raise( ArgumentError ){Meal_order.new("(4/2)","((4*8)/2)","(((9/3)*2)+3)","((24*4)/6)","(65/5)")}
  end

  # Can not stop the conversion from automatically from hex to an integer,
  # a primitive conversion. Built into Ruby.
  def test_Meal_order_initializer_all_hex_integer
    assert_raise( ArgumentError ){Meal_order.new(0x90,0x26,0x10,0x10,0x10)}
  end

  def test_Meal_order_initializer_all_hex_nils
    assert_raise( ArgumentError ){Meal_order.new(0xf0a1,0xf0a1,0xf0a1,0xf0a1,0xf0a1)}
  end

  def test_Meal_order_initializer_max_value
    n_BYTES = [100].pack('i').size
    n_BITS = n_BYTES * 16
    max = 2 ** (n_BITS - 2) - 1
    mIN = -max - 1
    assert_nothing_raised( ArgumentError ){Meal_order.new(max,1,1,1,1)}
  end

  def test_Meal_order_initializer_empty
    assert_raise( ArgumentError ){Meal_order.new('\n','\n','\n','\n','\n')}
  end
#-----------------------------------------------------------------------------------------------------

<<-DOC
  #Dealing with this set of test cases later, can't figure out how to create Ruby unit
  #test cases that require a pre-established input for the variable.


  def test_Meal_order_get_info_normal
    assert_nothing_raised( RuntimeError ){Meal_order.get_info("This is", " how the")}
  end

  def test_Meal_order_get_info_nil
    assert_nothing_raised( RuntimeError ){Meal_order.get_info(nil, nil)}
  end

  def test_Meal_order_get_info_integers
    assert_nothing_raised( RuntimeError ){Meal_order.get_info(56, 56)}
  end

  def test_Meal_order_get_info_hex
    assert_nothing_raised( RuntimeError ){Meal_order.get_info(0x70, 0x91)}
  end
DOC

#-----------------------------------------------------------------------------------------------------

  #def test_Meal_order_get_info_hex_nil
  #  assert_nothing_raised( RuntimeError ){Meal_order.get_info(0xf0a1, 0xf0a1)}
  #end

  #def test_Meal_order_initializer_


end
