class CreateActivity < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :activity_type
      t.string :uuid
      t.string :skill
      t.string :language
      t.integer :level

      t.timestamps
    end
  end
end
