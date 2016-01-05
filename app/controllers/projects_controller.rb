class ProjectsController < ApplicationController
    before_action :load_projects, only: :index
    #importantes to be before "load_and..." action
    load_and_authorize_resource
    #load_resource replaces "project.find and Project.new lines", new index edit acctions
    #authorize_resoure replaces all authorize! lines
    
    #def index thanks to first line is no longer needed
    #    @projects = Project.all
    #    authorize! :index, @projects
    #end
    
    #def new
    #    @project =  Project.new
    #    authorize! :new, @project
    #end
    
    def create
        #@project = Project.new(project_params) is automaticlly executed thanks to first line
        if @project.save
            flash[:success] = "project added"
        else
            render 'new'
        end
        #authorize! :create, @project
    end
    
    #def edit
    #    @project = Project.find(params[:id])
    #    authorize! :edit, @project
    #end
    
    def update
        #@project = Project.find(params[:id]) is no longer needed thanks to first line
        if @project.update_attributes(project_params)
            flash[:success] = "updated!"
            redirect_to root_path
        else
            render 'edit'
        end
        #authorize! :update, @project
    end
    
    def destroy
        #@project = Project.find(params[:id])
        if @project.destroy
            flash[:success] = 'destroyed'
        else
            flash[:warning] = 'cannot destroy project'
        end
        redirect_to root_path
        #authorize! :destroy, @project
    end
    
    private
    
    def project_params
        params.require(:project).permit(:title)
    end
    
    def load_projects
        @projects = Project.accessible_by(current_ability).order('created_at DESC')
    end
    
end
