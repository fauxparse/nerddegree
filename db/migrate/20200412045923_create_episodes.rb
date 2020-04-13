class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.string   :title
      t.date     :date
      t.string   :url
      t.integer  :number
      t.text     :content
      t.integer  :size

      t.timestamps
    end
  end
end
