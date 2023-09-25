class CreateTrace < ActiveRecord::Migration[7.0]
  def change
    create_table :traces do |t|

      t.references :activity
      t.references :student
      t.float :score

      t.timestamps
    end
  end
end
