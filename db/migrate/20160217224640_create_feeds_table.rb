class CreateFeedsTable < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string   :feedid
      t.decimal  :mag
      t.string   :place
      t.datetime :time
      t.string   :alert
      t.decimal  :latitude, :precision => 15, :scale => 10
      t.decimal  :longtitude, :precision => 15, :scale => 10
      t.timestamps
    end
  end
end