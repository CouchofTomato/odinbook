class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|

      t.string :firstname
      t.string :lastname
      t.datetime :date_of_birth
      t.string :gender
      t.string :website
      t.string :github_profile
      t.string :phone_number
      t.string :address_line_one
      t.string :address_line_two
      t.string :city
      t.string :country
      t.string :post_code
      t.string :odin_profile_link
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
