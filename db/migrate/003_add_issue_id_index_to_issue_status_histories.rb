class AddIssueIdIndexToIssueStatusHistories < ActiveRecord::Migration[4.2]
  def self.up
    add_index :issue_status_histories, :issue_id
  end

  def self.down
    remove_index :issue_status_histories, :issue_id
  end
end