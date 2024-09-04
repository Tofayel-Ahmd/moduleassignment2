import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int pullOverQuantity = 1;
  int tShirtQuantity = 1;
  int sportDressQuantity = 1;

  final int pullOverPrice = 51;
  final int tShirtPrice = 30;
  final int sportDressPrice = 43;

  int getTotalAmount() {
    return (pullOverQuantity * pullOverPrice) +
        (tShirtQuantity * tShirtPrice) +
        (sportDressQuantity * sportDressPrice);
  }

  void showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Congratulations on your purchase!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Bag")),
      body: Column(
        children: [
          itemRow('Pullover', 'Red', 'L',  pullOverQuantity, pullOverPrice,
              'lib/assets/pullover.png', (newQuantity) {
                setState(() {
                  pullOverQuantity = newQuantity;
                });
              }),
          itemRow('T-Shirt', 'Black', 'XL', tShirtQuantity, tShirtPrice,
              'lib/assets/tshirt.png', (newQuantity) {
                setState(() {
                  tShirtQuantity = newQuantity;
                });
              }),
          itemRow('Sport Dress', 'Yellow', 'M', sportDressQuantity,
              sportDressPrice, 'lib/assets/sport_dress.png', (newQuantity) {
                setState(() {
                  sportDressQuantity = newQuantity;
                });
              }),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total amount: ${getTotalAmount()}\$',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                showSnackbar(context);
              },
              child: Text('CHECK OUT'),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemRow(String name, String color, String size, int quantity, int price,
      String imagePath, Function(int) onQuantityChanged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            imagePath,  // Corrected here
            width: 100,
            height: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Color: $color'),
              Text('Size: $size'),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 1) {
                    onQuantityChanged(quantity - 1);
                  }
                },
              ),
              Text('$quantity'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  onQuantityChanged(quantity + 1);
                },
              ),
            ],
          ),
          Text('${price * quantity}\$',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
