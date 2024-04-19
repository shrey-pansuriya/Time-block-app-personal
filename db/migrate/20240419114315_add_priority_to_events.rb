class AddPriorityToEvents < ActiveRecord::Migration[7.1]
    def change
      add_column :events, :priority, :integer, default: 0 unless column_exists?(:events, :priority)
    end
  end
  