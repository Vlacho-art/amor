import 'package:flutter/material.dart';

// Colores del diseño
const kPink = Color(0xFFE6007E);
const kCardBg = Color(0xFFF5F5F7);
const kGreyText = Color(0xFF9B9BA1);

class CartItem {
  final String name;
  final String variantLabel;
  final String variantValue;
  final double price;
  int quantity;
  final Gradient imageGradient;

  CartItem({
    required this.name,
    required this.variantLabel,
    required this.variantValue,
    required this.price,
    required this.quantity,
    required this.imageGradient,
  });
}

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final List<CartItem> _items = [
    CartItem(
      name: 'Rose Petal Silk Blindfold',
      variantLabel: 'Color',
      variantValue: 'Midnight Black',
      price: 24.99,
      quantity: 1,
      imageGradient: const LinearGradient(
        colors: [Color(0xFFE9DFC9), Color(0xFFD8C9A8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    CartItem(
      name: 'Scented Soy Massage Candle',
      variantLabel: 'Scent',
      variantValue: 'Vanilla Musk',
      price: 18.50,
      quantity: 2,
      imageGradient: const LinearGradient(
        colors: [Color(0xFFF0C766), Color(0xFFE8B94C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ];

  double get _subtotal =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);
  final double _shipping = 5.00;
  double get _tax => _subtotal * 0.08;
  double get _total => _subtotal + _shipping + _tax;

  void _updateQuantity(int index, int delta) {
    setState(() {
      final newQty = _items[index].quantity + delta;
      if (newQty >= 1) _items[index].quantity = newQty;
    });
  }

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                ...List.generate(
                  _items.length,
                  (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildCartCard(i),
                  ),
                ),
                const SizedBox(height: 8),
                _buildSummaryRow('Subtotal', _subtotal),
                const SizedBox(height: 10),
                _buildSummaryRow('Shipping', _shipping),
                const SizedBox(height: 10),
                _buildSummaryRow('Tax', _tax),
                const SizedBox(height: 12),
                _buildDashedDivider(),
                const SizedBox(height: 12),
                _buildSummaryRow('Total', _total, isTotal: true),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Proceed to Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartCard(int index) {
    final item = _items[index];
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/detail'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: item.imageGradient,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _removeItem(index),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: kGreyText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.variantLabel}: ${item.variantValue}',
                  style: const TextStyle(fontSize: 12.5, color: kGreyText),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: kPink,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    _buildQuantityStepper(index, item.quantity),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
       ),
     );
  }

  Widget _buildQuantityStepper(int index, int quantity) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E5)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => _updateQuantity(index, -1),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                '-',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '$quantity',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          InkWell(
            onTap: () => _updateQuantity(index, 1),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                '+',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: isTotal ? Colors.black : kGreyText,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDashedDivider() {
    return SizedBox(
      height: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final dashCount = (constraints.constrainWidth() / 10).floor();
          return Flex(
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return const SizedBox(
                width: 5,
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xFFE0E0E5)),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
