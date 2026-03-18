import 'dart:math';
import 'package:flutter/material.dart';
import '../models/hero.dart';
import '../services/shop_service.dart';
import '../extensions/string_ext.dart';

class DartLabPage extends StatefulWidget {
  const DartLabPage({super.key});

  @override
  State<DartLabPage> createState() => _DartLabPageState();
}

class _DartLabPageState extends State<DartLabPage> {
  String output = 'Tekan tombol untuk melihat demo Dart!';

  void show(String text) {
    setState(() => output = text);
  }

  void demoVariablesAndNullSafety() {
    var name = 'Rani';
    final hp = 100;
    const maxLevel = 10;
    String? guild;
    final guildName = guild ?? 'No Guild';
    final guildUpper = guildName.toUpperCase();
    final List<int?> potions = [1, null, 3];

    final monsterName = "dark goblin".toTitleCase();

    show([
      '=== Variables + Null Safety ===',
      'Monster (TitleCase): $monsterName',
      'name (var): $name',
      'hp (final): $hp',
      'maxLevel (const): $maxLevel',
      'guildName (??): $guildName',
      'guildUpper: $guildUpper',
      'potions: $potions',
    ].join('\n'));
  }

  void demoFunctions() {
    int add(int a, int b) => a + b;

    String greet(String name, [String? title]) {
      if (title == null) return 'Halo $name!';
      return 'Halo $title $name!';
    }

    String castSpell({required String spell, int manaCost = 10}) {
      return '🪄 Cast $spell (mana -$manaCost)';
    }

    int applyTwice(int value, int Function(int) f) {
      return f(f(value));
    }

    show([
      '=== Functions ===',
      'add(2,3) => ${add(2, 3)}',
      'greet("Rani") => ${greet('Rani')}',
      'castSpell => ${castSpell(spell: 'Fireball')}',
      'applyTwice => ${applyTwice(3, (x) => x * 2)}',
    ].join('\n'));
  }

  void demoCollections() {
    final rng = Random();
    final monsters = ['Slime', 'Goblin', 'Wolf', 'Dragon'];
    final loot = {'gold': 120, 'potion': 2, 'gem': 1};
    final randomMonster = monsters[rng.nextInt(monsters.length)];
    final rewards = [
      '🎁 Daily Reward',
      'Random Monster: ${randomMonster.toTitleCase()}',
      for (final item in loot.keys) '• ${item.toTitleCase()}: ${loot[item]} pcs',
    ];

    show([
      '=== Collections (List/Map) ===',
      'Monsters: $monsters',
      'Rewards Inventory:',
      ...rewards,
    ].join('\n'));
  }

  void demoClasses() {
    // Buat objek awal
    final heroAwal = HeroRpg(
      name: 'Rani',
      job: Job.mage,
      baseHp: 80,
      baseMp: 120,
      inventory: const {},
    );

    // Tantangan 1: Harus me-return objek BARU (Immutable)
    final heroSetelahHeal = heroAwal.heal(10);

    show([
      '=== Class & Heal (Immutable) ===',
      'Nama: ${heroSetelahHeal.name}',
      'HP Awal: ${heroAwal.baseHp}',
      'HP Setelah Heal (+10): ${heroSetelahHeal.baseHp}',
      'Power: ${heroSetelahHeal.power}',
    ].join('\n'));
  }

  Future<void> demoAsyncAwait() async {
    show('⏳ Mengambil item dari Shop Service...');
    try {
      final items = await ShopService().fetchShopItems();
      final formattedItems = items.map((e) => e.toTitleCase()).join(', ');
      
      show([
        '=== Async Shop Items ===',
        'Items didapat: $formattedItems',
      ].join('\n'));
    } catch (e) {
      show('❌ Gagal: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dart Lab RPG'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: demoVariablesAndNullSafety,
                  icon: const Icon(Icons.bolt),
                  label: const Text('Variables'),
                ),
                ElevatedButton.icon(
                  onPressed: demoFunctions,
                  icon: const Icon(Icons.functions),
                  label: const Text('Functions'),
                ),
                ElevatedButton.icon(
                  onPressed: demoCollections,
                  icon: const Icon(Icons.list_alt),
                  label: const Text('Collections'),
                ),
                ElevatedButton.icon(
                  onPressed: demoClasses,
                  icon: const Icon(Icons.shield),
                  label: const Text('Heal Hero'),
                ),
                ElevatedButton.icon(
                  onPressed: demoAsyncAwait,
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Fetch Shop'),
                ),
                OutlinedButton.icon(
                  onPressed: () => show('Tekan tombol untuk melihat demo Dart!'),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    output,
                    style: const TextStyle(fontFamily: 'monospace', height: 1.35),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}