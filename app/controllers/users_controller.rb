class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [ :edit, :update, :destroy, :index, :show]
  before_filter :require_admin, only: [ :index ]

  handles_sortable_columns

  # GET /users
  # GET /users.json
  def index
    @users = User.search(params[:q]).order(order).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.xml { render xml: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end


  private

  #authorization
  def require_ownership
    @user = require_model_ownership(User)
  end

  def require_admin
    if current_user.nil? || !current_user.admin
      respond_to do |format|
        format.html { redirect_to :home, alert: "Only admins can complete that action." }
      end
    end
  end

  # Sorting behavior for studies
  def order
    order = sortable_column_order do |column, direction|
      case column
      when "name", "username", "email"
        "LOWER(#{column}) #{direction}"
      when "admin"
        "#{column} #{direction}"
      else
        'LOWER(username) ASC'
      end
    end
  end
end
