import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smile Bar',
      debugShowCheckedModeBanner: false,
      home: CrepeShopHomePage(),
    );
  }
}

class Crepe {
  String name;
  double price;
  String imageUrl;
  bool isFavorite;

  Crepe({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

class CrepeShopHomePage extends StatefulWidget {
  @override
  _CrepeShopHomePageState createState() => _CrepeShopHomePageState();
}

class _CrepeShopHomePageState extends State<CrepeShopHomePage> {
  final Color mainAccent = const Color(0xFFE98D5A);
  final Color priceColor = const Color(0xFF9C5A40);

  List<Crepe> crepes = [
    Crepe(
      name: 'Fettuccine Crepe',
      price: 5.99,
      imageUrl: 'assets/fettuccinecrepe.png',
    ),
    Crepe(
      name: 'Lotus Fruit Pancake',
      price: 6.49,
      imageUrl: 'assets/lotusfruitpancake.png',
    ),
    Crepe(
      name: 'Dubai Pancake',
      price: 6.99,
      imageUrl: 'assets/dubaipancake.png',
    ),
    Crepe(
      name: 'Strawberry Pancake',
      price: 7.49,
      imageUrl: 'assets/strawberrypancake.png',
    ),
  ];

  String searchText = '';

  void toggleFavorite(int index) {
    setState(() {
      crepes[index].isFavorite = !crepes[index].isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Crepe> displayedCrepes = crepes.where((crepe) {
      return crepe.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        shadowColor: Colors.orange.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        title: Text(
          'Smile Bar',
          style: TextStyle(
            color: mainAccent,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            shadows: [
              Shadow(
                blurRadius: 2,
                color: Colors.grey,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.black87),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Cart functionality not implemented')),
              );
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, color: mainAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'POPULAR',
                  style: TextStyle(
                    color: mainAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationColor: mainAccent,
                    decorationThickness: 2,
                  ),
                ),
                SizedBox(width: 20),
                Text('SWEET',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500)),
                SizedBox(width: 20),
                Text('FRUITY',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500)),
                SizedBox(width: 20),
                Text('SAVORY',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: displayedCrepes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  var crepe = displayedCrepes[index];

                  int originalIndex = crepes.indexOf(crepe);

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                crepe.imageUrl,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () => toggleFavorite(originalIndex),
                                child: Icon(
                                  crepe.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: crepe.isFavorite
                                      ? Colors.red
                                      : Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          crepe.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$${crepe.price.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 14, color: priceColor),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('${crepe.name} added to cart!'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: mainAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child:
                                  Icon(Icons.add, color: Colors.white, size: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: mainAccent,
        unselectedItemColor: Colors.grey[500],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
        onTap: (index) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Navigation not implemented'),
              duration: Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
}
