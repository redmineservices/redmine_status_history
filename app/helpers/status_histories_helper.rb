module StatusHistoriesHelper
  
  def first_status(issue)
    issue.issue_status_histories.first.status if issue.issue_status_histories.any?
  end
  
  def issue_status_changes(issue)
    if issue.issue_status_histories.any?
      issue.issue_status_histories.drop(1)
    else
      []
    end
  end
end
