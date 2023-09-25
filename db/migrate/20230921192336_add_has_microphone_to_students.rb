class AddHasMicrophoneToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :has_microphone, :bool, default: true
  end
end
