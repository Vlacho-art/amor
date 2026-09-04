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

  // =========================================================
  // ESCALA RESPONSIVA
  // =========================================================

  late double _s;

  void _computeScale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Escala aumentada para celulares.
    // Antes llegaba máximo a 1.25.
    // Ahora puede llegar hasta 1.40.
    _s = (width / 390).clamp(1.0, 1.40);
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
                padding: EdgeInsets.fromLTRB(sp(16), sp(12), sp(16), sp(14)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategories(),

                    SizedBox(height: sp(22)),

                    // =================================================
                    // TITULO
                    // =================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Featured Products',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: sp(20),
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                              color: const Color(0xFF20252A),
                            ),
                          ),
                        ),

                        SizedBox(width: sp(12)),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Filters',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: sp(14),
                                fontWeight: FontWeight.w600,
                                color: pink,
                              ),
                            ),

                            SizedBox(width: sp(6)),

                            Icon(Icons.tune, size: sp(19), color: pink),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: sp(14)),

                    // =================================================
                    // PRODUCTOS
                    // =================================================
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,

                        crossAxisSpacing: sp(12),
                        mainAxisSpacing: sp(14),

                        // Tarjetas más altas para que
                        // las letras grandes tengan espacio.
                        childAspectRatio: 0.64,
                      ),
                      itemBuilder: (_, index) {
                        return _buildProduct(products[index], index);
                      },
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
      padding: EdgeInsets.fromLTRB(sp(18), sp(14), sp(18), sp(10)),
      child: Row(
        children: [
          Icon(Icons.favorite, color: pink, size: sp(28)),

          SizedBox(width: sp(9)),

          Text(
            "L'Amour",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: sp(24),
              fontWeight: FontWeight.w800,
              height: 1.1,
              color: const Color(0xFF20252A),
            ),
          ),

          const Spacer(),

          Icon(Icons.search, size: sp(28), color: const Color(0xFF536273)),

          SizedBox(width: sp(22)),

          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: sp(30),
                color: const Color(0xFF536273),
              ),

              Positioned(
                right: -sp(8),
                top: -sp(9),
                child: Container(
                  width: sp(22),
                  height: sp(22),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: pink,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '2',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: sp(12),
                      fontWeight: FontWeight.w800,
                      height: 1,
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
  // CATEGORIAS
  // =========================================================

  Widget _buildCategories() {
    return SizedBox(
      height: sp(48),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) {
          return SizedBox(width: sp(10));
        },
        itemBuilder: (_, index) {
          final selected = selectedCategory == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: sp(20)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? pink : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: selected ? pink : const Color(0xFFD5DADE),
                  width: 1,
                ),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: sp(14),
                  height: 1,
                  color: selected ? Colors.white : const Color(0xFF4F5965),
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // =========================================================
  // PRODUCTO
  // =========================================================

  Widget _buildProduct(_Product product, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE1E5E8), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // IMAGEN
          // =====================================================
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
                        top: Radius.circular(12),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.asset(
                        product.imagePath,
                        width: double.infinity,
                        height: double.infinity,

                        // Mantiene la imagen sin deformarla.
                        fit: BoxFit.cover,

                        // Máxima calidad disponible.
                        filterQuality: FilterQuality.high,

                        alignment: Alignment.center,

                        errorBuilder: (_, _, _) {
                          return Center(
                            child: Icon(
                              product.icon,
                              size: sp(45),
                              color: Colors.black.withValues(alpha: 0.35),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // =================================================
                  // SALE
                  // =================================================
                  if (product.dark)
                    Positioned(
                      left: sp(10),
                      top: sp(10),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: sp(11),
                          vertical: sp(6),
                        ),
                        decoration: BoxDecoration(
                          color: pink,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'SALE',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: sp(12),
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                      ),
                    ),

                  // =================================================
                  // FAVORITO
                  // =================================================
                  Positioned(
                    right: sp(10),
                    top: sp(10),
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
                              width: sp(36),
                              height: sp(36),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEDEFF1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                favoriteProducts.contains(index)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: sp(21),
                                color: favoriteProducts.contains(index)
                                    ? pink
                                    : const Color(0xFF4F5965),
                              ),
                            )
                          : Icon(
                              favoriteProducts.contains(index)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: sp(25),
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

          // =====================================================
          // INFORMACION
          // =====================================================
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.fromLTRB(sp(11), sp(9), sp(11), sp(9)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =================================================
                  // CATEGORIA
                  // =================================================
                  Text(
                    product.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: sp(11),
                      color: const Color(0xFF8D969F),
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),

                  SizedBox(height: sp(5)),

                  // =================================================
                  // NOMBRE
                  // =================================================
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: sp(15),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF252A2F),
                      height: 1.15,
                    ),
                  ),

                  SizedBox(height: sp(6)),

                  // =================================================
                  // PRECIO
                  // =================================================
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.price,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: sp(16),
                          color: pink,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),

                      if (product.originalPrice != null) ...[
                        SizedBox(width: sp(7)),

                        Flexible(
                          child: Text(
                            product.originalPrice!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: sp(12),
                              color: const Color(0xFF9AA2A8),
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const Spacer(),

                  // =================================================
                  // BOTON
                  // =================================================
                  SizedBox(
                    width: double.infinity,
                    height: sp(38),
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
                        padding: EdgeInsets.symmetric(horizontal: sp(5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: Text(
                        'ADD TO CART',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: sp(12),
                          fontWeight: FontWeight.w800,
                          height: 1,
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
      height: sp(76),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E8EB))),
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
                    size: sp(27),
                    color: selected ? pink : const Color(0xFF9CA4AC),
                  ),

                  SizedBox(height: sp(5)),

                  Text(
                    labels[index],
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: sp(12),
                      color: selected ? pink : const Color(0xFF9CA4AC),
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      height: 1,
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

// =============================================================
// MODELO DEL PRODUCTO
// =============================================================

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