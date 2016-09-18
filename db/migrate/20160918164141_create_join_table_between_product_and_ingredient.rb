class CreateJoinTableBetweenProductAndIngredient < ActiveRecord::Migration[5.0]
  def change
    create_table :products_ingredients, id: false do |t|
      t.belongs_to :product, index: true
      t.belongs_to :ingredient, index: true
    end
  end
end
