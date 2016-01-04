class ProjectsController < ApplicationController
    def index
        @projects = Project.all
        authorize! :index, @projects
    end
end
