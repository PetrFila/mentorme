class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  # before_action :set_skills, only: [:new, :edit, :update, :create, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    #if current_user.profile.present?
      #render :layout => false
    #else
      @profiles = Profile.all
    #end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show

  end

  # GET /profiles/new
  def new
    if current_user.profile.present?
      redirect_to profile_path(current_user.profile.id), notice: 'Sorry, you already have this profile.'
    end
    @profile = Profile.new
    @skills = Skill.all
  end

  # GET /profiles/1/edit
  def edit
@skills = Skill.all
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
@skills = Skill.all
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    @skills = Skill.all
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:image, :first_name, :last_name, :about, :skill=>[])
    end

     def set_skills
       @skills = Skill.find(params[:id])
     end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_params
      params.require(:skill).permit(:name)
    end
end