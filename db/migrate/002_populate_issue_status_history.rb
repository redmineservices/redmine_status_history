class PopulateIssueStatusHistory < (Rails.version < '5.2' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2])
  def change
    
    Issue.find_each do |i|
      last_change = nil
    
      changes = i.journals.collect {|j| j.details.select {|d| d.prop_key == 'status_id' }}.flatten.sort
      if changes
        puts "Issue ##{i.id} - #{changes.count} changes "
        changes.each do |c|
          if last_change.nil?
            status_history = {
              :from => i.created_on,
              :status_id => c.old_value,
              :user_id => i.author_id,
              :issue_id => i.id,
              :to => c.journal.created_on
            }
            last_change = IssueStatusHistory.create!(status_history)            
          else
            last_change.to = c.journal.created_on
            last_change.save
          end
          
          status_history = {
            :from => c.journal.created_on,
            :status_id => c.value,
            :user_id => c.journal.user_id,
            :journal_id => c.journal_id,
            :previous_status_id => c.old_value,
            :issue_id => c.journal.journalized_id
          }
          last_change = IssueStatusHistory.create!(status_history)            
        end
      else
        status_history = {
          :from => i.created_on,
          :status_id => i.status_id,
          :user_id => i.author_id,
          :issue_id => i.id
        }
        IssueStatusHistory.create!(status_history)
      end
    end    
  end
end