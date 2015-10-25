class CreateReportInfos < ActiveRecord::Migration
  def change
    create_table :report_infos do |t|
      t.text :emails
      t.string :subject
      t.text :models

      t.timestamps null: false
    end
  end
end
