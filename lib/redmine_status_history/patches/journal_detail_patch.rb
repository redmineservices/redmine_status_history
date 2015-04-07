require_dependency 'journal_detail'

module RedmineStatusHistory
  module Patches
    module JournalDetailPatch
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development
          has_one :issue_status_history, :dependent => :delete
          
          after_create :create_history
        end
      end 
      
      module InstanceMethods     
        def create_history
          last_change = self.journal.issue.issue_status_histories.last
          if self.prop_key == 'status_id'
            status_history = {
              :from => self.journal.created_on,
              :status_id => self.value,
              :user_id => self.journal.user_id,
              :journal_id => self.journal_id,
              :previous_status_id => self.old_value,
              :issue_id => self.journal.journalized_id
            }
            IssueStatusHistory.create(status_history)
            if last_change && self.journal
              last_change.to = self.journal.created_on
              last_change.save      
            end                          
          end
        end
      end            
    end
  end
end

unless JournalDetail.included_modules.include?(RedmineStatusHistory::Patches::JournalDetailPatch)
  JournalDetail.send(:include, RedmineStatusHistory::Patches::JournalDetailPatch)
end