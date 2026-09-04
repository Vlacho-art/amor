import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const pink = Color(0xFFE91E63);
  int selectedCategory = 0;
  int selectedTab = 0;

  final categories = const ['All', 'Toys', 'Lingerie', 'Wellness'];
  final products = const [
    _Product('TOYS', 'Velvet Touch Wand', '\$49.99', Icons.auto_fix_high,
        Color(0xFFDDEDE0)),
    _Product('LINGERIE', 'Midnight Lace...', '\$34.50', Icons.checkroom,
        Color(0xFFF1E8DA)),
    _Product('WELLNESS', 'Starlit Warming Oil', '\$18.00', Icons.local_drink,
        Color(0xFFFFD878)),
    _Product('SILKY', 'Silky Rabbit 2.0', '\$55.00', Icons.toys,
        Color(0xFF273036), true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategories(),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Featured Products',
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w700)),
                        Text('Filters  ⚙',
                            style: TextStyle(fontSize: 9, color: pink)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 8,
                        childAspectRatio: .68,
                      ),
                      itemBuilder: (_, index) => _buildProduct(products[index]),
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 3),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: pink, size: 16),
          const SizedBox(width: 4),
          const Text("L'Amour",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
          const Spacer(),
          const Icon(Icons.search, size: 15, color: Color(0xFF536273)),
          const SizedBox(width: 15),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/shopping'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_bag_outlined,
                    size: 17, color: Color(0xFF536273)),
                Positioned(
                  right: -5,
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                        color: pink, shape: BoxShape.circle),
                    child: const Text('2',
                        style: TextStyle(color: Colors.white, fontSize: 7)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 26,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 6),
        itemBuilder: (_, index) {
          final selected = selectedCategory == index;
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? pink : Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: selected ? pink : const Color(0xFFE2E5E9)),
              ),
              child: Text(categories[index],
                  style: TextStyle(
                      fontSize: 8,
                      color: selected ? Colors.white : const Color(0xFF4F5965),
                      fontWeight:
                          selected ? FontWeight.w700 : FontWeight.w400)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProduct(_Product product) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/detail'),
      borderRadius: BorderRadius.circular(6),
      child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE7E9EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 12,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: product.background,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(6)),
                  ),
                  child: Center(
                    child: Icon(product.icon,
                        size: 64,
                        color: product.dark
                            ? const Color(0xFFE8E9E5)
                            : const Color(0xFFB77652)),
                  ),
                ),
                if (product.dark)
                  Positioned(
                    left: 5,
                    top: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                          color: pink, borderRadius: BorderRadius.circular(3)),
                      child: const Text('SALE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 7,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                const Positioned(
                  right: 5,
                  top: 5,
                  child: Icon(Icons.favorite_border,
                      size: 14, color: Color(0xFF9AA2A8)),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 5, 6, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.category,
                      style: const TextStyle(
                          fontSize: 6,
                          color: Color(0xFF98A0A8),
                          letterSpacing: .3)),
                  const SizedBox(height: 3),
                  Text(product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 9, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(product.price,
                      style: const TextStyle(
                          fontSize: 9,
                          color: pink,
                          fontWeight: FontWeight.w800)),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 21,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFFFCE4EF),
                        foregroundColor: pink,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: const Text('ADD TO CART',
                          style: TextStyle(
                              fontSize: 7, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    const labels = ['Home', 'Catalog', 'Orders', 'Profile'];
    const icons = [
      Icons.home_outlined,
      Icons.view_list_outlined,
      Icons.receipt_long_outlined,
      Icons.person_outline
    ];
    return Container(
      height: 49,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE9EBEE)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(labels.length, (index) {
          final selected = selectedTab == index;
          return GestureDetector(
            onTap: () => setState(() => selectedTab = index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icons[index], size: 15, color: selected ? pink : const Color(0xFF9CA4AC)),
                const SizedBox(height: 2),
                Text(labels[index],
                    style: TextStyle(
                        fontSize: 7, color: selected ? pink : const Color(0xFF9CA4AC))),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _Product {
  final String category;
  final String name;
  final String price;
  final IconData icon;
  final Color background;
  final bool dark;

  const _Product(this.category, this.name, this.price, this.icon, this.background,
      [this.dark = false]);
}
