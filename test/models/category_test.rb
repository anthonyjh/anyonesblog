require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
   
   #runs before every test
   def setup
      @category = Category.new(name: "sports")
   end
   
   test "category should be valid" do
      #uses an assertion
      assert @category.valid?
   end
   
   test "name should be present" do
      @category.name = " "
      assert_not @category.valid?  #if this returns true, then the test will fail
   end
   
   test "name should be unique" do
      @category.save      #hits test db
      category2 = Category.new(name: "sports")
      assert_not category2.valid?  #category2 should not be valid with the same name as category 1
   end
   
   test "name should not be too long" do
      @category.name = "a" * 35    #test to see if max length of name is 34 characters long
      assert_not @category.valid?
   end
   
   test "name should not be too short" do
      @category.name = "aa"
      assert_not @category.valid?
   end
   
end