class ProductReport < Dossier::Report
  def sql
    "SELECT * FROM products WHERE #{ids_where}"
    # "SELECT * FROM products WHERE id IN (1, 2, 3, 4, 5)"
  end

  def ids_where
    "id IN :ids" if options[:id].present?
  end

  def ids
    options[:id][1..-2].split(",").map(&:to_i)
  end

  # def sql
  #   Product.where("id IN ?", :ids).to_sql
  # end
end