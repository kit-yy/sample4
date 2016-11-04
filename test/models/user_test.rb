require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

   def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  test "should be valid?" do
    assert @user.valid?
  end  

  test "name should be presence?" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "name should not be too long 50" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should accept valid address?" do
    valid_address = %w[user@example.com, user.com, okokok]
    valid_address.each do |a|
      @user.email = a
      assert @user.valid?
    end
  end

end
