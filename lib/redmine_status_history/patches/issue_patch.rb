require_dependency 'issue'

module RedmineStatusHistory
  module Patches
    module IssuePatch
      unloadable
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do         
          has_many :issue_status_histories, :dependent => :delete_all
          
          after_create :create_status_history         
        end
      end

      module InstanceMethods
        def create_status_history
          status_history = {
            :from => self.created_on,
            :status_id => self.status_id,
            :user_id => self.author_id,
            :issue_id => self.id
          }
          IssueStatusHistory.create!(status_history)  
        end  
      end      
    end
  end
end

unless Issue.included_modules.include?(RedmineStatusHistory::Patches::IssuePatch)
  Issue.send(:include, RedmineStatusHistory::Patches::IssuePatch)
end


