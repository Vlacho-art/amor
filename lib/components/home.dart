import 'package:flutter/material.dart';
import 'descrit.dart';
import 'shopping.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const pink = Color(0xFFE91E63);

  int selectedCategory = 0;
  int selectedTab = 0;

  final Set<int> favoriteProducts = <int>{1};

  final categories = const ['All', 'Toys', 'Lingerie', 'Wellness'];

  final products = const [
    _Product(
      'TOYS',
      'Velvet Touch Wand',
      '\$49.99',
      Icons.auto_fix_high,
      Color(0xFFDDEDE0),
      'assets/img/product_perfume.jpg',
    ),
    _Product(
      'LINGERIE',
      'Midnight Lace...',
      '\$34.50',
      Icons.checkroom,
      Color(0xFFF1E8DA),
      'assets/img/product_lingerie.jpg',
    ),
    _Product(
      'WELLNESS',
      'Santal Warming Oil',
      '\$18.00',
      Icons.local_drink,
      Color(0xFFFFD878),
      'assets/img/product_gel.jpg',
    ),
    _Product(
      'TOYS',
      'Silky Rabbit 2.0',
      '\$55.00',
      Icons.toys,
      Color(0xFF273036),
      'assets/img/product_bunny.jpg',
      true,
      '\$75.00',
    ),
  ];

  // Escala para Pixel 7
  late double _s;

  void _computeScale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    _s = (width / 393).clamp(0.95, 1.15);
  }

  double sp(double base) => base * _s;

  @override
  Widget build(BuildContext context) {
    _computeScale(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(sp(12), sp(8), sp(12), sp(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategories(),

                    SizedBox(height: sp(16)),

                    // TÍTULO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Featured Products',
                          style: TextStyle(
                            fontSize: sp(19),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF20252B),
                          ),
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Filters',
                              style: TextStyle(
                                fontSize: sp(15),
                                color: pink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(width: sp(5)),

                            Icon(Icons.tune, size: sp(17), color: pink),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: sp(10)),

                    // PRODUCTOS
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,

                        crossAxisSpacing: sp(10),
                        mainAxisSpacing: sp(10),

                        // Tarjetas un poquito más altas
                        // para evitar el overflow amarillo
                        childAspectRatio: 0.61,
                      ),
                      itemBuilder: (_, index) =>
                          _buildProduct(products[index], index),
                    ),
                  ],
                ),
              ),
            ),

            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(sp(16), sp(16), sp(16), sp(10)),
      child: Row(
        children: [
          Icon(Icons.favorite, color: pink, size: sp(24)),

          SizedBox(width: sp(8)),

          Text(
            "L'Amour",
            style: TextStyle(
              fontSize: sp(22),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF20252B),
            ),
          ),

          const Spacer(),

          Icon(Icons.search, size: sp(24), color: const Color(0xFF536273)),

          SizedBox(width: sp(20)),

          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: sp(26),
                color: const Color(0xFF536273),
              ),

              Positioned(
                right: -sp(7),
                top: -sp(8),
                child: Container(
                  padding: EdgeInsets.all(sp(3)),
                  constraints: BoxConstraints(
                    minWidth: sp(17),
                    minHeight: sp(17),
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: pink,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sp(10),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CATEGORÍAS
  // =========================================================

  Widget _buildCategories() {
    return SizedBox(
      height: sp(42),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => SizedBox(width: sp(8)),
        itemBuilder: (_, index) {
          final selected = selectedCategory == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: sp(18)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? pink : Colors.white,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: selected ? pink : const Color(0xFFE2E5E9),
                ),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: sp(15),

                  // Un poquito más gruesa
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,

                  color: selected ? Colors.white : const Color(0xFF4F5965),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // =========================================================
  // PRODUCTOS
  // =========================================================

  Widget _buildProduct(_Product product, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: const Color(0xFFE7E9EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =================================================
          // IMAGEN
          // =================================================
          Expanded(
            flex: 13,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const Descrit()),
                );
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: product.background,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(9),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(9),
                      ),
                      child: Image.asset(
                        product.imagePath,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        errorBuilder: (_, _, _) {
                          return Center(
                            child: Icon(
                              product.icon,
                              size: sp(38),
                              color: Colors.black.withValues(alpha: 0.35),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // SALE
                  if (product.dark)
                    Positioned(
                      left: sp(7),
                      top: sp(7),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: sp(7),
                          vertical: sp(4),
                        ),
                        decoration: BoxDecoration(
                          color: pink,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'SALE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: sp(10),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                  // FAVORITO
                  Positioned(
                    right: sp(7),
                    top: sp(7),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (favoriteProducts.contains(index)) {
                            favoriteProducts.remove(index);
                          } else {
                            favoriteProducts.add(index);
                          }
                        });
                      },
                      child: product.dark
                          ? Container(
                              padding: EdgeInsets.all(sp(5)),
                              decoration: const BoxDecoration(
                                color: Color(0xFFEDEFF1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                favoriteProducts.contains(index)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: sp(16),
                                color: favoriteProducts.contains(index)
                                    ? pink
                                    : const Color(0xFF4F5965),
                              ),
                            )
                          : Icon(
                              favoriteProducts.contains(index)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: sp(20),
                              color: favoriteProducts.contains(index)
                                  ? pink
                                  : const Color(0xFF9AA2A8),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // =================================================
          // INFORMACIÓN
          // =================================================
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.fromLTRB(sp(9), sp(7), sp(9), sp(7)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CATEGORÍA
                  Text(
                    product.category,
                    style: TextStyle(
                      fontSize: sp(10),
                      color: const Color(0xFF98A0A8),
                      fontWeight: FontWeight.w600,
                      letterSpacing: .4,
                    ),
                  ),

                  SizedBox(height: sp(3)),

                  // NOMBRE
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: sp(14),

                      // Un poco más gruesa
                      fontWeight: FontWeight.w600,

                      color: const Color(0xFF20252B),
                    ),
                  ),

                  SizedBox(height: sp(3)),

                  // PRECIO
                  Row(
                    children: [
                      Text(
                        product.price,
                        style: TextStyle(
                          fontSize: sp(14),
                          color: pink,

                          // Más gruesa
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      if (product.originalPrice != null) ...[
                        SizedBox(width: sp(5)),

                        Text(
                          product.originalPrice!,
                          style: TextStyle(
                            fontSize: sp(11),
                            color: const Color(0xFF9AA2A8),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const Spacer(),

                  // =================================================
                  // BOTÓN ADD TO CART
                  // =================================================
                  SizedBox(
                    width: double.infinity,

                    // Un poquito más alto para
                    // evitar el overflow
                    height: sp(31),

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const ShoppingCartScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFFFCE4EF),
                        foregroundColor: pink,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'ADD TO CART',
                        style: TextStyle(
                          fontSize: sp(11),

                          // Más gruesa
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BARRA INFERIOR
  // =========================================================

  Widget _buildBottomNavigation() {
    const labels = ['Home', 'Catalog', 'Orders', 'Profile'];

    const icons = [
      Icons.home_outlined,
      Icons.view_list_outlined,
      Icons.receipt_long_outlined,
      Icons.person_outline,
    ];

    return Container(
      height: sp(64),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE9EBEE))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(labels.length, (index) {
          final selected = selectedTab == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = index;
              });
            },
            child: SizedBox(
              width: sp(70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icons[index],
                    size: sp(23),
                    color: selected ? pink : const Color(0xFF9CA4AC),
                  ),

                  SizedBox(height: sp(3)),

                  Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: sp(11),

                      // Un poco más gruesa
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,

                      color: selected ? pink : const Color(0xFF9CA4AC),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// =========================================================
// MODELO DEL PRODUCTO
// =========================================================

class _Product {
  final String category;
  final String name;
  final String price;
  final IconData icon;
  final Color background;
  final String imagePath;
  final bool dark;
  final String? originalPrice;

  const _Product(
    this.category,
    this.name,
    this.price,
    this.icon,
    this.background,
    this.imagePath, [
    this.dark = false,
    this.originalPrice,
  ]);
}
