require File.dirname(__FILE__) + '/../spec_helper'

describe AccomodationsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Accomodation.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Accomodation.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Accomodation.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(accomodation_url(assigns[:accomodation]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Accomodation.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Accomodation.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Accomodation.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Accomodation.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Accomodation.first
    response.should redirect_to(accomodation_url(assigns[:accomodation]))
  end

  it "destroy action should destroy model and redirect to index action" do
    accomodation = Accomodation.first
    delete :destroy, :id => accomodation
    response.should redirect_to(accomodations_url)
    Accomodation.exists?(accomodation.id).should be_false
  end
end
