class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
t.string :title #作品名
t.text :image_url #作品画像url
t.string :director #監督名
t.text :detail #あらすじ
t.string :open_date　#公開日
      t.timestamps
    end
  end
end
