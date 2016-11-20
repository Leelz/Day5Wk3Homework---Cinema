require('minitest/autorun')
require('minitest/rg')
require('pry-byebug')
require_relative('../customers')
require('pry-byebug')

class TestBoard < MiniTest::Test

  def setup
    @customer1 = Customer.new({"name" => "Stan", "funds" => 50})
  end

  def test_customer_has_name()
    assert_equal("Stan", @customer1.name)
  end

  def test_customer_can_update()
    @customer1[:funds]=30
    @customer1.update
    assert_equal(30, @customer)
  end





end


