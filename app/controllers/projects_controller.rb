class ProjectsController < ApplicationController
    def index
        @projects = Project.all
        authorize! :index, @projects
    end
    
    def new
        @project =  Project.new
        authorize! :new, @project
    end
    
    def create
        @project = Project.new(project_params)
        if @project.save
            flash[:success] = "project added"
        else
            render 'new'
        end
        authorize! :create, @project
    end
    
    def edit
        @project = Project.find(params[:id])
        authorize! :edit, @project
    end
    
    def update
        @project = Project.find(params[:id])
        if @project.update_attributes(project_params)
            flash[:success] = "updated!"
            redirect_to root_path
        else
            render 'edit'
        end
        authorize! :update, @project
    end
    
    def destroy
        @project = Project.find(params[:id])
        if @project.destroy
            flash[:success] = 'destroyed'
        else
            flash[:warning] = 'cannot destroy project'
        end
        redirect_to root_path
        authorize! :destroy, @project
    end
    
    private
    
    def project_params
        params.require(:project).permit(:title)
    end
end
