import 'package:flutter/material.dart';
import 'details_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Navigation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Product> products = [
    Product(name: "Pixel 1", description: "Pixel is the most featureful phone ever", price: 800, color: Colors.blue),
    Product(name: "Laptop", description: "Laptop is the most productive development tool", price: 2000, color: Colors.green),
    Product(name: "Tablet", description: "Tablet is the most useful device ever for meetings", price: 1500, color: Colors.yellow),
    Product(name: "Pen Drive", description: "Pen Drive is the most portable storage device", price: 100, color: Colors.red),
    Product(name: "Floppy Drive", description: "Floppy Drive is the legacy storage device", price: 50, color: Colors.lightBlueAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Navigation")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(product: products[index]),
                        ),
                      ).then((_) => setState(() {})); // Refresh when returning
                    },
                    child: Container(
                      color: products[index].color,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        products[index].name.toLowerCase(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(products[index].description),
                        Text("Price: \$${products[index].price}"),
                        Row(
                          children: List.generate(3, (starIndex) {
                            return IconButton(
                              icon: Icon(
                                starIndex < products[index].rating ? Icons.star : Icons.star_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  products[index].rating = starIndex + 1; // Update rating
                                });
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final int price;
  final Color color;
  int rating; // Add rating property

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.color,
    this.rating = 0, // Default rating is 0
  });
}
