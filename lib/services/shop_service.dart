class ShopService {
  Future<List<String>> fetchShopItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return ["Health Potion", "Mana Crystal", "Iron Sword"];
  }
}