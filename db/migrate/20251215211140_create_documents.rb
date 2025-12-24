class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.text :description
      t.string :category # For categorizing documents by page

      t.timestamps
    end
  end
end
