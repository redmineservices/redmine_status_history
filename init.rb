require 'redmine'

Redmine::Plugin.register :redmine_status_history do
  name 'Redmine Status History plugin'
  author '@redmineservices'
  description 'This is a plugin for Redmine'
  version '1.0.2'
  url 'http://redmineservices.com'
  author_url 'mailto:info@redmineservices.com'
  
  project_module :issue_tracking do
    permission :search_status_history, {}, :require => :member
  end

  require File.expand_path('lib/redmine_status_history/hooks/view_issues_index_bottom', __dir__)
  require File.expand_path('lib/redmine_status_history/patches/issue_patch', __dir__)
  require File.expand_path('lib/redmine_status_history/patches/journal_detail_patch', __dir__)

  if Rails.configuration.respond_to?(:autoloader) && Rails.configuration.autoloader == :zeitwerk
    Rails.autoloaders.each { |loader| loader.ignore(File.expand_path('lib/redmine_status_history', __dir__)) }
  end

  if Rails.version > '6.0' && Rails.autoloaders.zeitwerk_enabled?
    JournalDetail.send(:include, RedmineStatusHistory::Patches::JournalDetailPatch)
    Issue.send(:include, RedmineStatusHistory::Patches::IssuePatch)
  else
    Rails.configuration.to_prepare do
      JournalDetail.send(:include, RedmineStatusHistory::Patches::JournalDetailPatch)
      Issue.send(:include, RedmineStatusHistory::Patches::IssuePatch)
    end
  end
end