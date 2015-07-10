class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :app, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :events, :apps
  end
end
