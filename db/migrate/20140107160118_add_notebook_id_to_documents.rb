class AddNotebookIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :notebook_id, :integer
    add_index  :documents, :notebook_id
  end
end
