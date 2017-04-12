class Schema < ActiveRecord::Migration
  def change
    create_table :foo_api_infos, force: true do |t|
      t.string :internal_param1
      t.string :internal_param2
    end
    create_table :foo2_api_infos, force: true do |t|
      t.string :internal_param1
      t.string :internal_param2
    end
    create_table :foo3_api_infos, force: true do |t|
      t.string :internal_param1
      t.string :internal_param2
    end
  end
end