// JSON Assignment:

/* Graded Assessment: Working with JSON Data

Problem:

You are tasked with implementing a product management system. The system will use JSON data for storing information about products. Each product has the following properties:

· id: Unique identifier for the product.

· name: Name of the product.

· category: Category of the product.

· price: Price of the product.

· available: Boolean indicating if the product is in stock.

The tasks below involve reading JSON data, adding new products, updating product information, and filtering products based on certain conditions.


Tasks:

1. Parse the JSON data:

Write a function that reads the JSON data (in the format above) and converts it into a usable data structure. You will need to parse the JSON into a JavaScript object.

2. Add a new product:

Write a function to add a new product to the catalog. This product will have the same structure as the others and should be appended to the products array.

3. Update the price of a product:

Write a function that takes a product ID and a new price and updates the price of the product with the given ID. If the product doesn’t exist, the function should return an error message.

4. Filter products based on availability:

Write a function that returns only the products that are available (i.e., available: true).

5. Filter products by category:

Write a function that takes a category name (e.g., "Electronics") and returns all products in that category. */

const jsonData = `
[
  {"id": 1, "name": "Laptop", "category": "Electronics", "price": 100000, "available": true},
  {"id": 2, "name": "Chair", "category": "Furniture", "price": 150, "available": false},
  {"id": 3, "name": "Smartphone", "category": "Electronics", "price": 70000, "available": true}
]`;


function parseData(data) {
  try {
    const products = JSON.parse(data);
    console.log("Parsed Data:", products);
    return products;
  } catch (error) {
    console.error("Invalid JSON data:", error);
    return [];
  }
}


let products = parseData(jsonData);


function addProduct(newProduct) {
  if (products.some(product => product.id === newProduct.id)) {
    console.error("Product with this ID already exists.");
  } else {
    products.push(newProduct);
    console.log("Product added:", newProduct);
  }
}


function updatePrice(productId, newPrice) {
  const product = products.find(product => product.id === productId);
  if (product) {
    product.price = newPrice;
    console.log("Updated product price:", product);
  } else {
    console.error("Product not found.");
  }
}

function filterByAvailability() {
  const availableProducts = products.filter(product => product.available);
  console.log("Available products:", availableProducts);
  return availableProducts;
}

function filterByCategory(category) {
  const productsByCategory = products.filter(product => product.category === category);
  console.log(`Products in category "${category}":`, productsByCategory);
  return productsByCategory;
}

addProduct({"id": 4, "name": "Table", "category": "Furniture", "price": 200, "available": true});

updatePrice(1, 120000);

filterByAvailability();

filterByCategory("Electronics");
