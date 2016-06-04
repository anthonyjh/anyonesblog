require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
   
   def setup
      @category = Category.create(name: "sports")
      @user = User.create(username: "John", email: "john@example.com", password: "password", admin: true) #create test admin user
   end
   
   #first test-ensure we have all routes and access to those routes
   test "should get categories index" do
      get :index
      assert_response :success  #ensure response is success
   end
   
   test "should get new" do
      #simulate admin is logged in since user above in setup is created as admin
      session[:user_id] = @user.id
      get :new
      assert_response :success
   end
   
   test "should get show" do
      get(:show, {'id' => @category.id})  #generate the route for particular category
      assert_response :success
   end
   
   test "should redirect create when admin not logged in" do
      assert_no_difference 'Category.count' do
         post :create, category: {name: "sports"}
      end
      assert_redirected_to categories_path  #in this test, no logged in user so when try to create sport category it redirects to category index
   end
   
end