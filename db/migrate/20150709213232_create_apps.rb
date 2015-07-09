class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.reference :user
      t.string :title
      t.string :url

      t.timestamps null: false
    end
  end
end
