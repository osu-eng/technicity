class ComparisonsController < ApplicationController
  # GET /comparisons
  # GET /comparisons.json
  def index
    @comparisons = Comparison.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comparisons }
    end
  end

  # GET /comparisons/1
  # GET /comparisons/1.json
  def show
    @comparison = Comparison.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comparison }
    end
  end

  # GET /comparisons/new
  # GET /comparisons/new.json
  def new
    @comparison = Comparison.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comparison }
    end
  end

  # GET /comparisons/1/edit
  def edit
    @comparison = Comparison.find(params[:id])
  end

  # POST /comparisons
  # POST /comparisons.json
  def create
    @comparison = Comparison.new(params[:comparison])

    respond_to do |format|
      if @comparison.save
        format.html { redirect_to @comparison, notice: 'Comparison was successfully created.' }
        format.json { render json: @comparison, status: :created, location: @comparison }
      else
        format.html { render action: "new" }
        format.json { render json: @comparison.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comparisons/1
  # PUT /comparisons/1.json
  def update
    @comparison = Comparison.find(params[:id])

    respond_to do |format|
      if @comparison.update_attributes(params[:comparison])
        format.html { redirect_to @comparison, notice: 'Comparison was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comparison.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comparisons/1
  # DELETE /comparisons/1.json
  def destroy
    @comparison = Comparison.find(params[:id])
    @comparison.destroy

    respond_to do |format|
      format.html { redirect_to comparisons_url }
      format.json { head :no_content }
    end
  end
end
