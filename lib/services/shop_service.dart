class ShopService {
  Future<List<String>> fetchShopItems() async {
    // Simulasi loading 1 detik sesuai tantangan
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      'healing potion',
      'mana elixir',
      'iron sword',
      'magic wand',
    ];
  }
}