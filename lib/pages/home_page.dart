import 'package:flutter/material.dart';
import '../models/hero.dart';
import '../extensions/string_ext.dart';
import '../services/shop_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. Hapus 'const' karena HeroRpg biasanya punya Map (inventory) yang tidak bisa const
  HeroRpg hero = HeroRpg(
    name: "hero",
    job: Job.warrior,
    baseHp: 100,
    baseMp: 50,
    inventory: {},
  );

  List<String> shopItems = [];
  bool loading = false;

  // 2. Tambahkan angka di dalam heal(10) sesuai parameter yang kita buat
  void healHero() {
    setState(() {
      hero = hero.heal(10);
    });
  }

  void addRandomItem() {
    if (shopItems.isEmpty) return;
    final item = (List<String>.from(shopItems)..shuffle()).first;
    setState(() {
      hero = hero.addItem(item);
    });
  }

  void loadShop() async {
    setState(() {
      loading = true;
    });

    // 3. Panggil fungsi dari ShopService() bukan langsung fetchShopItems
    final items = await ShopService().fetchShopItems();

    setState(() {
      shopItems = items;
      loading = false;
    });
  }

  String formatInventory() {
    if (hero.inventory.isEmpty) return "Empty";
    return hero.inventory.entries
        .map((e) => "${e.key.toTitleCase()} x${e.value}")
        .join("\n");
  }

  @override
  void initState() {
    super.initState();
    loadShop();
  }

  @override
  Widget build(BuildContext context) {
    final monsterName = "dark goblin".toTitleCase();

    return Scaffold(
      appBar: AppBar(title: const Text("RPG")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Hero HP: ${hero.baseHp}"),
            const SizedBox(height: 10),
            Text("Monster: $monsterName"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: healHero,
              child: const Text("Heal +10"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addRandomItem,
              child: const Text("Add Random Item"),
            ),
            const SizedBox(height: 20),
            const Text("Inventory:"),
            Text(formatInventory()),
            const SizedBox(height: 20),
            loading
                ? const CircularProgressIndicator()
                : Column(
                    children: shopItems
                        .map((e) => Text(e.toTitleCase()))
                        .toList(),
                  ),
          ],
        ),
      ),
    );
  }
}