import 'package:flutter/material.dart';

// Colores del diseño
const kPink = Color(0xFFE6007E);
const kCardBg = Color(0xFFF5F5F7);
const kGreyText = Color(0xFF9B9BA1);
const kBorderGrey = Color(0xFFE0E0E5);

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
    // --- Escalado responsivo para pantallas pequeñas y grandes (ej. Pixel 7) ---
    final width = MediaQuery.of(context).size.width;
    // Referencia: diseño base pensado para ~375px de ancho.
    // Se agrega un "boost" (1.15) para que en celulares reales (Pixel 7, etc.)
    // el contenido se vea grande y legible, no diminuto.
    final scale = (width / 375).clamp(1.0, 1.3) * 1.15;
    final horizontalPadding = 16.0 * scale;

    return Scaffold(
      backgroundColor: kCardBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: kBorderGrey, width: 1)),
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20 * scale,
            ),
            title: Text(
              'Shopping Cart',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18 * scale,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                18,
                horizontalPadding,
                8,
              ),
              children: [
                ...List.generate(
                  _items.length,
                  (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildCartCard(i, scale),
                  ),
                ),
                const SizedBox(height: 8),
                _buildSummaryRow('Subtotal', _subtotal, scale),
                const SizedBox(height: 10),
                _buildSummaryRow('Shipping', _shipping, scale),
                const SizedBox(height: 10),
                _buildSummaryRow('Tax', _tax, scale),
                const SizedBox(height: 12),
                _buildDashedDivider(),
                const SizedBox(height: 12),
                _buildSummaryRow('Total', _total, scale, isTotal: true),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: kBorderGrey, width: 1)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  12,
                  horizontalPadding,
                  12,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Proceed to Checkout',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16 * scale,
                          ),
                        ),
                        SizedBox(width: 8 * scale),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 18 * scale,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartCard(int index, double scale) {
    final item = _items[index];
    return Container(
      padding: EdgeInsets.all(12 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56 * scale,
            height: 56 * scale,
            decoration: BoxDecoration(
              gradient: item.imageGradient,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.5 * scale,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _removeItem(index),
                      child: Icon(
                        Icons.close,
                        size: 18 * scale,
                        color: kGreyText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.variantLabel}: ${item.variantValue}',
                  style: TextStyle(fontSize: 12.5 * scale, color: kGreyText),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: kPink,
                        fontWeight: FontWeight.w700,
                        fontSize: 15 * scale,
                      ),
                    ),
                    _buildQuantityStepper(index, item.quantity, scale),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityStepper(int index, int quantity, double scale) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kBorderGrey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => _updateQuantity(index, -1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                '-',
                style: TextStyle(fontSize: 16 * scale, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          InkWell(
            onTap: () => _updateQuantity(index, 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                '+',
                style: TextStyle(fontSize: 16 * scale, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    double value,
    double scale, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: (isTotal ? 16 : 14) * scale,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: isTotal ? Colors.black : kGreyText,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: (isTotal ? 18 : 14) * scale,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDashedDivider() {
    return const SizedBox(
      height: 1,
      child: DecoratedBox(decoration: BoxDecoration(color: kBorderGrey)),
    );
  }
}
