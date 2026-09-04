import 'package:flutter/material.dart';

class Descrit extends StatefulWidget {
  const Descrit({super.key});

  @override
  State<Descrit> createState() => _DescritState();
}

class _DescritState extends State<Descrit> {
  static const _background = Color(0xFFFFFBFC);
  static const _ink = Color(0xFF241D27);
  static const _muted = Color(0xFF857B84);
  static const _pink = Color(0xFFD94772);
  static const _softPink = Color(0xFFFBE6ED);

  int _quantity = 1;

  void _changeQuantity(int amount) {
    final nextQuantity = _quantity + amount;
    if (nextQuantity < 1) return;
    setState(() => _quantity = nextQuantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: _ink,
          tooltip: 'Back',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share_rounded, size: 20),
            color: _ink,
            tooltip: 'Share',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined, size: 22),
            color: _ink,
            tooltip: 'Shopping bag',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _softPink,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'BESTSELLER',
                      style: TextStyle(
                        color: _pink,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.star_rounded, color: Color(0xFFF1B54A), size: 18),
                  const SizedBox(width: 4),
                  const Text(
                    '4.9 (128)',
                    style: TextStyle(
                      color: _muted,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Velvet Touch Rechargeable Wand',
                style: TextStyle(
                  color: _ink,
                  fontSize: 27,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '\$89.00',
                style: TextStyle(
                  color: _pink,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 28),
              _buildSectionTitle('Description'),
              const SizedBox(height: 10),
              const Text(
                'Experience ultimate relaxation with the Velvet Touch. Crafted '
                'from medical-grade silicone, this powerful wand offers 10 '
                'distinct vibration modes and a flexible head designed to '
                'reach every curve. Whisper-quiet and fully waterproof for '
                'versatile use.',
                style: TextStyle(
                  color: _muted,
                  fontSize: 15,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _buildFeature('Material', 'Premium Silicone')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildFeature('Run Time', '120 Minutes')),
                ],
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  _buildQuantitySelector(),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _pink,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      height: 285,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7E9EE),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/img/maquillaje.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.88),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_rounded),
                color: _pink,
                iconSize: 22,
                tooltip: 'Add to favorites',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: _ink,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildFeature(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0E7EA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: _muted, fontSize: 12)),
          const SizedBox(height: 5),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _ink,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF0E7EA)),
      ),
      child: Row(
        children: [
          _buildQuantityButton(Icons.remove_rounded, () => _changeQuantity(-1)),
          SizedBox(
            width: 25,
            child: Text(
              '$_quantity',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _ink,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          _buildQuantityButton(Icons.add_rounded, () => _changeQuantity(1)),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      color: _ink,
      splashRadius: 20,
      tooltip: icon == Icons.add_rounded ? 'Increase quantity' : 'Decrease quantity',
    );
  }
}