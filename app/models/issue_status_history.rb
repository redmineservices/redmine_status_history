class IssueStatusHistory < ActiveRecord::Base
  unloadable
  
  belongs_to :status, :class_name => 'IssueStatus', :foreign_key => 'status_id'
  belongs_to :user
  belongs_to :journal
  belongs_to :issue
  
  
  def self.search_changes(project, status_id, date_from, previous_status=nil, date_to=nil)
    
    conditions = {
      :status_id => status_id,
      :from => date_from.to_date..(date_to.nil? ? Date.tomorrow : date_to.to_date.tomorrow)
    }
    
    conditions[:previous_status_id] = previous_status if previous_status
    
    Issue.where(:project_id => project.id).joins(:issue_status_histories).where({:issue_status_histories => conditions}).uniq
    
  end
end
