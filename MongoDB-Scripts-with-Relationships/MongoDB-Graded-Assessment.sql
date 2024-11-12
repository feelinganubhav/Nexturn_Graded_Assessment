Graded Assessment: MongoDB Scripts with Relationships

Scenario Overview:

You are working with an e-commerce platform. The platform has two collections:

1. Customers collection: Contains information about each customer.

2. Orders collection: Contains information about orders placed by customers.

Each customer can have multiple orders, but each order is linked to only one customer.

Customer Document Structure:

{ "_id": ObjectId("unique_id"), "name": "John Doe", "email": "johndoe@example.com", "address": { "street": "123 Main St", "city": "Springfield", "zipcode": "12345" }, "phone": "555-1234", "registration_date": ISODate("2023-01-01T12:00:00Z") }

Order Document Structure:

{ "_id": ObjectId("unique_id"), "order_id": "ORD123456", "customer_id": ObjectId("unique_customer_id"), // Reference to a Customer document "order_date": ISODate("2023-05-15T14:00:00Z"), "status": "shipped", "items": [ { "product_name": "Laptop", "quantity": 1, "price": 1500 }, { "product_name": "Mouse", "quantity": 2, "price": 25 } ], "total_value": 1550 }



Open the command prompt/terminal to start the server:

> mongod
Output: Server is running at the default port.

Open another command prompt/terminal to play with data using MongoDB Shell:

> mongosh
Output: MongoDB Shell has started, Read and Write access is available.
	
> show dbs
Output: 
admin      40.00 KiB
config     72.00 KiB
local      72.00 KiB
sampledb  144.00 KiB

-- Switch to or Create New Database:	
	
test> use assignmentdb
Output: switched to db assignmentdb
	
-- To check under which database I am:

assignmentdb> db
Output:	assignmentdb

Part 1: Basic MongoDB Commands and Queries

Objective: Understand and demonstrate basic CRUD operations on collections with relationships.

Instructions: Write MongoDB scripts for the following tasks:

1. Create the Collections and Insert Data:

o Create two collections: customers and orders.

assignmentdb> db.createCollection("customers");
{ ok: 1 }

assignmentdb> db.createCollection("orders");
{ ok: 1 }

-- To see collections:

assignmentdb> show collections
customers
orders

o Insert 5 customer documents into the customers collection.

assignmentdb> db.customers.insertMany([
...     { "_id": ObjectId(), "name": "Anubhav Ranjan", "email": "anubhav@gmail.com", "address": { "street": "123 MG Road", "city": "kolkata", "zipcode": "400001" }, "phone": "9876543210", "registration_date": ISODate("2023-01-05T10:00:00Z") },
...     { "_id": ObjectId(), "name": "Anushree Sharma", "email": "anushree@gmail.com", "address": { "street": "456 JP Nagar", "city": "Bengaluru", "zipcode": "560078" }, "phone": "9123456789", "registration_date": ISODate("2023-02-12T14:30:00Z") },
...     { "_id": ObjectId(), "name": "Amit Kumar", "email": "amit@gmail.com", "address": { "street": "789 Salt Lake", "city": "Kolkata", "zipcode": "700091" }, "phone": "9988776655", "registration_date": ISODate("2023-03-18T12:15:00Z") },
...     { "_id": ObjectId(), "name": "Priya Desai", "email": "priyadesai@gmail.com", "address": { "street": "321 SV Road", "city": "Ahmedabad", "zipcode": "380015" }, "phone": "8899776655", "registration_date": ISODate("2023-04-07T09:00:00Z") },
...     { "_id": ObjectId(), "name": "Arjun Patel", "email": "arjunpatel@gmail.com", "address": { "street": "654 GIDC Road", "city": "Surat", "zipcode": "395003" }, "phone": "8765432109", "registration_date": ISODate("2023-05-20T16:45:00Z") }
... ]);

Output:
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('6731c3ca4e0cf6e4e40d8190'),
    '1': ObjectId('6731c3ca4e0cf6e4e40d8191'),
    '2': ObjectId('6731c3ca4e0cf6e4e40d8192'),
    '3': ObjectId('6731c3ca4e0cf6e4e40d8193'),
    '4': ObjectId('6731c3ca4e0cf6e4e40d8194')
  }
}

assignmentdb> db.customers.find().pretty();
[
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8190'),
    name: 'Anubhav Ranjan',
    email: 'anubhav@gmail.com',
    address: { street: '123 MG Road', city: 'kolkata', zipcode: '400001' },
    phone: '9876543210',
    registration_date: ISODate('2023-01-05T10:00:00.000Z')
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8191'),
    name: 'Anushree Sharma',
    email: 'anushree@gmail.com',
    address: { street: '456 JP Nagar', city: 'Bengaluru', zipcode: '560078' },
    phone: '9123456789',
    registration_date: ISODate('2023-02-12T14:30:00.000Z')
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8192'),
    name: 'Amit Kumar',
    email: 'amit@gmail.com',
    address: { street: '789 Salt Lake', city: 'Kolkata', zipcode: '700091' },
    phone: '9988776655',
    registration_date: ISODate('2023-03-18T12:15:00.000Z')
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8193'),
    name: 'Priya Desai',
    email: 'priyadesai@gmail.com',
    address: { street: '321 SV Road', city: 'Ahmedabad', zipcode: '380015' },
    phone: '8899776655',
    registration_date: ISODate('2023-04-07T09:00:00.000Z')
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8194'),
    name: 'Arjun Patel',
    email: 'arjunpatel@gmail.com',
    address: { street: '654 GIDC Road', city: 'Surat', zipcode: '395003' },
    phone: '8765432109',
    registration_date: ISODate('2023-05-20T16:45:00.000Z')
  }
]

o Insert 5 order documents into the orders collection, each linked to a customer using the customer_id field (the _id of a customer document).

assignmentdb> db.orders.insertMany([
...     { "_id": ObjectId(), "order_id": "ORD0001", "customer_id": ObjectId("6731c3ca4e0cf6e4e40d8190"), "order_date": ISODate("2023-05-25T14:00:00Z"), "status": "shipped", "items": [ { "product_name": "Smartphone", "quantity": 1, "price": 15000 }, { "product_name": "Power Bank", "quantity": 1, "price": 1500 } ], "total_value": 16500 },
...     { "_id": ObjectId(), "order_id": "ORD0002", "customer_id": ObjectId("6731c3ca4e0cf6e4e40d8191"), "order_date": ISODate("2023-06-10T11:00:00Z"), "status": "delivered", "items": [ { "product_name": "Laptop", "quantity": 1, "price": 55000 } ], "total_value": 55000 },
...     { "_id": ObjectId(), "order_id": "ORD0003", "customer_id": ObjectId("6731c3ca4e0cf6e4e40d8192"), "order_date": ISODate("2023-06-15T13:30:00Z"), "status": "pending", "items": [ { "product_name": "Air Conditioner", "quantity": 1, "price": 30000 } ], "total_value": 30000 },

...     { "_id": ObjectId(), "order_id": "ORD0004", "customer_id": ObjectId("6731c3ca4e0cf6e4e40d8193"), "order_date": ISODate("2023-07-05T10:45:00Z"), "status": "shipped", "items": [ { "product_name": "Washing Machine", "quantity": 1, "price": 18000 } ], "total_value": 18000 },

...     { "_id": ObjectId(), "order_id": "ORD0005", "customer_id": ObjectId("6731c3ca4e0cf6e4e40d8194"), "order_date": ISODate("2023-07-20T12:20:00Z"), "status": "shipped", "items": [ { "product_name": "Television", "quantity": 1, "price": 25000 }, { "product_name": "Home Theatre", "quantity": 1, "price": 8000 } ], "total_value": 33000 }
... ]);

Output:
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('67327db34e0cf6e4e40d8195'),
    '1': ObjectId('67327db34e0cf6e4e40d8196'),
    '2': ObjectId('67327db34e0cf6e4e40d8197'),
    '3': ObjectId('67327db34e0cf6e4e40d8198'),
    '4': ObjectId('67327db34e0cf6e4e40d8199')
  }
}

assignmentdb> db.orders.find().pretty();
[
  {
    _id: ObjectId('67327db34e0cf6e4e40d8195'),
    order_id: 'ORD0001',
    customer_id: ObjectId('6731c3ca4e0cf6e4e40d8190'),
    order_date: ISODate('2023-05-25T14:00:00.000Z'),
    status: 'shipped',
    items: [
      { product_name: 'Smartphone', quantity: 1, price: 15000 },
      { product_name: 'Power Bank', quantity: 1, price: 1500 }
    ],
    total_value: 16500
  },
  {
    _id: ObjectId('67327db34e0cf6e4e40d8196'),
    order_id: 'ORD0002',
    customer_id: ObjectId('6731c3ca4e0cf6e4e40d8191'),
    order_date: ISODate('2023-06-10T11:00:00.000Z'),
    status: 'delivered',
    items: [ { product_name: 'Laptop', quantity: 1, price: 55000 } ],
    total_value: 55000
  },
  {
    _id: ObjectId('67327db34e0cf6e4e40d8197'),
    order_id: 'ORD0003',
    customer_id: ObjectId('6731c3ca4e0cf6e4e40d8192'),
    order_date: ISODate('2023-06-15T13:30:00.000Z'),
    status: 'pending',
    items: [ { product_name: 'Air Conditioner', quantity: 1, price: 30000 } ],
    total_value: 30000
  },
  {
    _id: ObjectId('67327db34e0cf6e4e40d8198'),
    order_id: 'ORD0004',
    customer_id: ObjectId('6731c3ca4e0cf6e4e40d8193'),
    order_date: ISODate('2023-07-05T10:45:00.000Z'),
    status: 'shipped',
    items: [ { product_name: 'Washing Machine', quantity: 1, price: 18000 } ],
    total_value: 18000
  },
  {
    _id: ObjectId('67327db34e0cf6e4e40d8199'),
    order_id: 'ORD0005',
    customer_id: ObjectId('6731c3ca4e0cf6e4e40d8194'),
    order_date: ISODate('2023-07-20T12:20:00.000Z'),
    status: 'shipped',
    items: [
      { product_name: 'Television', quantity: 1, price: 25000 },
      { product_name: 'Home Theatre', quantity: 1, price: 8000 }
    ],
    total_value: 33000
  }
]

2. Find Orders for a Specific Customer:

o Write a script to find all orders placed by a customer with the name “John Doe”. Use the customer’s _id to query the orders collection.

assignmentdb> const anubhav = db.customers.findOne({ "name": "Anubhav Ranjan" });

assignmentdb> db.orders.find({ "customer_id": anubhav._id });

Output:
[
  {
    _id: ObjectId('67327db34e0cf6e4e40d8195'),
    order_id: 'ORD0001',
    customer_id: ObjectId('6731c3ca4e0cf6e4e40d8190'),
    order_date: ISODate('2023-05-25T14:00:00.000Z'),
    status: 'shipped',
    items: [
      { product_name: 'Smartphone', quantity: 1, price: 15000 },
      { product_name: 'Power Bank', quantity: 1, price: 1500 }
    ],
    total_value: 16500
  }
]

3. Find the Customer for a Specific Order:

o Write a script to find the customer information for a specific order (e.g., order_id = “ORD123456”).

assignmentdb> const order = db.orders.findOne({ "order_id": "ORD0001" });

assignmentdb> db.customers.findOne({ "_id": order.customer_id });

Output:
{
  _id: ObjectId('6731c3ca4e0cf6e4e40d8190'),
  name: 'Anubhav Ranjan',
  email: 'anubhav@gmail.com',
  address: { street: '123 MG Road', city: 'kolkata', zipcode: '400001' },
  phone: '9876543210',
  registration_date: ISODate('2023-01-05T10:00:00.000Z')
}


4. Update Order Status:

o Write a script to update the status of an order to “delivered” where the order_id is “ORD0001”.

assignmentdb> db.orders.updateOne(
...     { "order_id": "ORD0001" },
...     { $set: { "status": "delivered" } }
... );

Output:
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}

assignmentdb> db.orders.findOne({ "order_id": "ORD0001" });
{
  _id: ObjectId('67327db34e0cf6e4e40d8195'),
  order_id: 'ORD0001',
  customer_id: ObjectId('6731c3ca4e0cf6e4e40d8190'),
  order_date: ISODate('2023-05-25T14:00:00.000Z'),
  status: 'delivered',
  items: [
    { product_name: 'Smartphone', quantity: 1, price: 15000 },
    { product_name: 'Power Bank', quantity: 1, price: 1500 }
  ],
  total_value: 16500
}

5. Delete an Order:

o Write a script to delete an order where the order_id is “ORD0001”.

assignmentdb> db.orders.deleteOne({ "order_id": "ORD0001" });

Output:
{ acknowledged: true, deletedCount: 1 }


Part 2: Aggregation Pipeline

Objective: Use MongoDB’s aggregation framework to perform more advanced queries, including working with related data across collections.

Instructions: Use the aggregation framework to solve the following tasks:

1. Calculate Total Value of All Orders by Customer:

o Write a script to calculate the total value of all orders for each customer. This should return each customer’s name and the total order value.

assignmentdb> db.orders.aggregate([
...     { $group: { _id: "$customer_id", total_spent: { $sum: "$total_value" } } },
...     { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer_info" } },
...     { $unwind: "$customer_info" },
...     { $project: { "customer_info.name": 1, total_spent: 1 } }
... ]);

Output:
[
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8193'),
    total_spent: 18000,
    customer_info: { name: 'Priya Desai' }
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8192'),
    total_spent: 30000,
    customer_info: { name: 'Amit Kumar' }
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8194'),
    total_spent: 33000,
    customer_info: { name: 'Arjun Patel' }
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8191'),
    total_spent: 55000,
    customer_info: { name: 'Anushree Sharma' }
  }
]

2. Group Orders by Status:

o Write a script to group orders by their status (e.g., “shipped”, “delivered”, etc.) and count how many orders are in each status.

assignmentdb> db.orders.aggregate([
...     { $group: { _id: "$status", count: { $sum: 1 } } }
... ]);

Output:
[
  { _id: 'pending', count: 1 },
  { _id: 'shipped', count: 2 },
  { _id: 'delivered', count: 1 }
]

3. List Customers with Their Recent Orders:

o Write a script to find each customer and their most recent order. Include customer information such as name, email, and order details (e.g., order_id, total_value).

assignmentdb> db.orders.aggregate([
...     { $sort: { "order_date": -1 } },
...     { $group: { _id: "$customer_id", latest_order: { $first: "$$ROOT" } } },
...     { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer_info" } },

...     { $unwind: "$customer_info" },
...     { $project: { "customer_info.name": 1, "customer_info.email": 1, "latest_order.order_id": 1, "latest_order.total_value": 1 } }
... ]);

Output:
[
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8193'),
    latest_order: { order_id: 'ORD0004', total_value: 18000 },
    customer_info: { name: 'Priya Desai', email: 'priyadesai@gmail.com' }
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8192'),
    latest_order: { order_id: 'ORD0003', total_value: 30000 },
    customer_info: { name: 'Amit Kumar', email: 'amit@gmail.com' }
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8194'),
    latest_order: { order_id: 'ORD0005', total_value: 33000 },
    customer_info: { name: 'Arjun Patel', email: 'arjunpatel@gmail.com' }
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8191'),
    latest_order: { order_id: 'ORD0002', total_value: 55000 },
    customer_info: { name: 'Anushree Sharma', email: 'anushree@gmail.com' }
  }

4. Find the Most Expensive Order by Customer:

o Write a script to find the most expensive order for each customer. Return the customer’s name and the details of their most expensive order (e.g., order_id, total_value).

assignmentdb> db.orders.aggregate([
...     { $sort: { "total_value": -1 } },
...     { $group: { _id: "$customer_id", most_expensive_order: { $first: "$$ROOT" } } },
...     { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer_info" } },
...     { $unwind: "$customer_info" },
...     { $project: { "customer_info.name": 1, "most_expensive_order.order_id": 1, "most_expensive_order.total_value": 1 } }
... ]);

Output:
[
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8192'),
    most_expensive_order: { order_id: 'ORD0003', total_value: 30000 },
    customer_info: { name: 'Amit Kumar' }
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8193'),
    most_expensive_order: { order_id: 'ORD0004', total_value: 18000 },
    customer_info: { name: 'Priya Desai' }
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8191'),
    most_expensive_order: { order_id: 'ORD0002', total_value: 55000 },
    customer_info: { name: 'Anushree Sharma' }
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8194'),
    most_expensive_order: { order_id: 'ORD0005', total_value: 33000 },
    customer_info: { name: 'Arjun Patel' }
  }
]


Part 3: Real-World Scenario with Relationships

Objective: Apply MongoDB operations to a real-world problem involving two related collections.

Scenario: You are working as a MongoDB developer for an e-commerce platform. The system needs to track customer orders, including the customer’s name, email, and address, as well as the items they ordered.

1. Find All Customers Who Placed Orders in the Last Month:

o Write a script to find all customers who have placed at least one order in the last 30 days. Return the customer name, email, and the order date for their most recent order.

assignmentdb> const lastMonth = new Date();

assignmentdb> lastMonth.setMonth(lastMonth.getMonth() - 1);
1728703745336
assignmentdb> db.orders.aggregate([
...   { $match: { "order_date": { $gte: lastMonth } } },
...   { $group: { "_id": "$customer_id", "lastOrderDate": { $max: "$order_date" } } },
...   { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer" } },
...   { $unwind: "$customer" },
...   { $project: { "customer.name": 1, "customer.email": 1, "lastOrderDate": 1 } }
... ]);


2. Find All Products Ordered by a Specific Customer:

o Write a script to find all distinct products ordered by a customer with the name “John Doe”. Include the product name and the total quantity ordered.

assignmentdb> const customer = db.customers.findOne({ "name": "Anushree Sharma" });

assignmentdb> db.orders.aggregate([
...   { $match: { "customer_id": customer._id } },
...   { $unwind: "$items" },
...   { $group: { "_id": "$items.product_name", "totalQuantity": { $sum: "$items.quantity" } } }
... ]);

Output:
[ { _id: 'Laptop', totalQuantity: 1 } ]

3. Find the Top 3 Customers with the Most Expensive Total Orders:

o Write a script to find the top 3 customers who have spent the most on orders. Sort the results by total order value in descending order.

assignmentdb> db.orders.aggregate([
...   { $group: { "_id": "$customer_id", "totalOrderValue": { $sum: "$total_value" } } },
...   { $sort: { "totalOrderValue": -1 } },
...   { $limit: 3 },
...   { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer" } },
...   { $unwind: "$customer" },
...   { $project: { "customer.name": 1, "totalOrderValue": 1 } }
... ]);

Output:
[
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8191'),
    totalOrderValue: 55000,
    customer: { name: 'Anushree Sharma' }
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8194'),
    totalOrderValue: 33000,
    customer: { name: 'Arjun Patel' }
  },
  {
    _id: ObjectId('6731c3ca4e0cf6e4e40d8192'),
    totalOrderValue: 30000,
    customer: { name: 'Amit Kumar' }
  }
]

4. Add a New Order for an Existing Customer:

o Write a script to add a new order for a customer with the name “Jane Smith”. The order should include at least two items, such as “Smartphone” and “Headphones”.

assignmentdb> const customer = db.customers.findOne({ "name": "Amit Kumar" });

assignmentdb> db.orders.insertOne({
...   "order_id": "ORD0006",
...   "customer_id": customer._id,
...   "order_date": new Date(),
...   "status": "pending",
...   "items": [
...     { "product_name": "Smartphone", "quantity": 1, "price": 800 },
...     { "product_name": "Headphones", "quantity": 1, "price": 100 }
...   ],
...   "total_value": 900
... });

Output:
{
  acknowledged: true,
  insertedId: ObjectId('6732cf2d4e0cf6e4e40d819a')
}

assignmentdb> db.customers.findOne({ "name": "Amit Kumar" });
{
  _id: ObjectId('6731c3ca4e0cf6e4e40d8192'),
  name: 'Amit Kumar',
  email: 'amit@gmail.com',
  address: { street: '789 Salt Lake', city: 'Kolkata', zipcode: '700091' },
  phone: '9988776655',
  registration_date: ISODate('2023-03-18T12:15:00.000Z')
}

assignmentdb> db.orders.findOne({ "order_id": "ORD0006" });
{
  _id: ObjectId('6732cf2d4e0cf6e4e40d819a'),
  order_id: 'ORD0006',
  customer_id: ObjectId('6731c3ca4e0cf6e4e40d8192'),
  order_date: ISODate('2024-11-12T03:44:45.341Z'),
  status: 'pending',
  items: [
    { product_name: 'Smartphone', quantity: 1, price: 800 },
    { product_name: 'Headphones', quantity: 1, price: 100 }
  ],
  total_value: 900
}

Part 4: Bonus Challenge

Objective: Demonstrate the ability to work with advanced MongoDB operations and complex relationships.

1. Find Customers Who Have Not Placed Orders:

o Write a script to find all customers who have not placed any orders. Return the customer’s name and email.

Inserting a new customer for better results..

assignmentdb> db.customers.insertOne({ "_id": ObjectId(), "name": "Jane Smith", "email": "janesmith@gmail.com", "address": { "street": "456 Elm St", "city": "Metropolis", "zipcode": "67890" }, "phone": "555-5678", "registration_date": ISODate("2023-02-15T09:30:00Z") });
{
  acknowledged: true,
  insertedId: ObjectId('6732d25f4e0cf6e4e40d819b')
}

assignmentdb> db.customers.aggregate([
...     {
...         $lookup: {
...             from: "orders",
...             localField: "_id",
...             foreignField: "customer_id",
...             as: "orders"
...         }
...     },
...     {
...         $match: { "orders": { $size: 0 } }
...     },
...     {
...         $project: {
...             _id: 0,
...             name: 1,
...             email: 1
...         }
...     }
... ]);

Output:
[
  { name: 'Anubhav Ranjan', email: 'anubhav@gmail.com' },
  { name: 'Jane Smith', email: 'janesmith@gmail.com' }
]

2. Calculate the Average Number of Items Ordered per Order:

o Write a script to calculate the average number of items ordered per order across all orders. The result should return the average number of items.

assignmentdb> db.orders.aggregate([
...     {
...         $project: {
...             numberOfItems: { $size: "$items" }
...         }
...     },
...     {
...         $group: {
...             _id: null,
...             averageItemsPerOrder: { $avg: "$numberOfItems" }
...         }
...     },
...     {
...         $project: {
...             _id: 0,
...             averageItemsPerOrder: 1
...         }
...     }
... ]);

Output:
[ { averageItemsPerOrder: 1.4 } ]

3. Join Customer and Order Data Using $lookup:

o Write a script using the $lookup aggregation operator to join data from the customers collection and the orders collection. Return customer name, email, order details (order_id, total_value), and order date.

assignmentdb> db.customers.aggregate([
...     {
...         $lookup: {
...             from: "orders",
...             localField: "_id",
...             foreignField: "customer_id",
...             as: "order_details"
...         }
...     },
...     {
...         $unwind: "$order_details"
...     },
...     {
...         $project: {
...             _id: 0,
...             name: 1,
...             email: 1,
...             "order_details.order_id": 1,
...             "order_details.total_value": 1,
...             "order_details.order_date": 1
...         }
...     }
... ]);

Output:
[
  {
    name: 'Anushree Sharma',
    email: 'anushree@gmail.com',
    order_details: {
      order_id: 'ORD0002',
      order_date: ISODate('2023-06-10T11:00:00.000Z'),
      total_value: 55000
    }
  },
  {
    name: 'Amit Kumar',
    email: 'amit@gmail.com',
    order_details: {
      order_id: 'ORD0003',
      order_date: ISODate('2023-06-15T13:30:00.000Z'),
      total_value: 30000
    }
  },
  {
    name: 'Amit Kumar',
    email: 'amit@gmail.com',
    order_details: {
      order_id: 'ORD0006',
      order_date: ISODate('2024-11-12T03:44:45.341Z'),
      total_value: 900
    }
  },
  {
    name: 'Priya Desai',
    email: 'priyadesai@gmail.com',
    order_details: {
      order_id: 'ORD0004',
      order_date: ISODate('2023-07-05T10:45:00.000Z'),
      total_value: 18000
    }
  },
  {
    name: 'Arjun Patel',
    email: 'arjunpatel@gmail.com',
    order_details: {
      order_id: 'ORD0005',
      order_date: ISODate('2023-07-20T12:20:00.000Z'),
      total_value: 33000
    }
  }
]
