require 'redmine'

require 'redmine_status_history/patches/issue_patch'
require 'redmine_status_history/patches/journal_detail_patch'

require 'redmine_status_history/hooks/view_issues_index_bottom'

Redmine::Plugin.register :redmine_status_history do
  name 'Redmine Status History plugin'
  author '@javiferrer'
  description 'This is a plugin for Redmine'
  version '1.0.0'
  url 'http://javiferrer.es'
  author_url 'http://twitter.com/javiferrer'
  
  project_module :issue_tracking do
    permission :search_status_history, {}, :require => :member
  end  
end
