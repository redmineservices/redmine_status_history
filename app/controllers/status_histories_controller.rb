class StatusHistoriesController < ApplicationController
  unloadable
  
  before_action :find_project_by_project_id


  def index
    
  end

  def show_history
    @issue = Issue.find(params[:issue_id])
  end

  def search
    @statuses = @project.trackers.collect {|t| t.issue_statuses}.flatten.uniq.sort {|s, t| s.name <=> t.name}
    @status_to = params[:status_to]
    @date_from = params[:date_from]
    @status_from = params[:status_from] if params[:status_from].present? 
    @date_to = params[:date_to] if params[:date_to].present?
    
    @issues = []
    
    if request.post?
      @issues = IssueStatusHistory.search_changes(@project, @status_to, @date_from, @status_from, @date_to)
    end
    
  end
      
end
