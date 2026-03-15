class AddActiveToListeDePrix < ActiveRecord::Migration[7.1]
  def change
    add_column :liste_de_prixes, :active, :boolean, default: false
  end
end
