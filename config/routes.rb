# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html



match 'projects/:project_id/issue_status_history/search' => 'status_histories#search', :via => [:get, :post], :as => 'search_status_history'
match 'projects/:project_id/issue_status_history/show_history/:issue_id' => 'status_histories#show_history', :via => [:get], :as => 'show_status_history'
