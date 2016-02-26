class CreateRequestsTable < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string   :location, :null => false
      t.decimal  :radius, :null => false
      t.decimal  :latitude, :precision => 15, :scale => 10
      t.decimal  :longtitude, :precision => 15, :scale => 10
      t.decimal  :magnitude, :null => false      
      t.integer  :user_id
      t.boolean  :notified, default: false
      t.timestamps
    end
  end
end
