class ProductReport < Dossier::Report
  def sql
    "SELECT * FROM products WHERE #{ids_in}"
    # Product.where("id IN ?", :ids_in).to_sql
  end

  def ids_in
    "id IN :ids" if options[:id].present?
  end

  def ids
    options[:id][1..-2].split(",").map(&:to_i)
  end
end