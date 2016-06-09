class ProductReport < Dossier::Report
  def sql
    "SELECT p.name AS \"Product Name\", m.company_name AS \"Manufacturer Name\", p.item_number, (p.price * 0.01) AS \"Price\", CASE WHEN p.category_id ISNULL THEN NULL ELSE c.category_name END AS \"Category Name\", p.min_order_quantity, p.description FROM products AS p LEFT JOIN manufacturers AS m ON p.manufacturer_id = m.id LEFT JOIN categories AS c ON c.id = p.category_id  WHERE #{ids_in}"
    # Product.where("id IN ?", :ids_in).to_sql
  end

  # If 'options[:id]' has any values, this method returns SQL query text to find all Products with ID values in the array returned by the 'ids' method. 
  def ids_in
    "p.id IN :ids" if options[:id].present?
  end

  # 'options[:id]' returns a String. This function removes the array brackets,
  # then splits the String on the comma, inserts them into an actual array, then remaps the values as integers.
  def ids
    options[:id][1..-2].split(",").map(&:to_i)
  end
end