module RedmineStatusHistory
  module Hooks
    class ViewHooks < Redmine::Hook::ViewListener
      render_on :view_issues_index_bottom, :partial => 'hooks/hook_link_to_status_history_search'
    end
  end
end