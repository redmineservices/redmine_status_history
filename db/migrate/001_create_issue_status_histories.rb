class CreateIssueStatusHistories < (Rails.version < '5.2' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2])
  def change
    create_table :issue_status_histories do |t|
      t.integer :issue_id
      t.integer :status_id
      t.integer :previous_status_id
      t.integer :journal_id
      t.integer :user_id
      t.datetime  :from
      t.datetime  :to
    end
    
    add_index(:issue_status_histories, [:status_id, :previous_status_id, :from], :name => 'issue_status_history_index')
  end
end
