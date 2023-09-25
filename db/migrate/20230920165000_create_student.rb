class CreateStudent < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|

      t.string :language

      t.timestamps
    end
  end
end
