enum Job {
  warrior('Warrior'),
  mage('Mage'),
  archer('Archer');

  final String label;
  const Job(this.label);
}

class HeroRpg {
  final String name;
  final Job job;
  final int baseHp;
  final int baseMp;
  final Map<String, int> inventory;

  const HeroRpg({
    required this.name,
    required this.job,
    required this.baseHp,
    required this.baseMp,
    required this.inventory,
  });

  int get power => baseHp + baseMp;

  HeroRpg levelUp(int n) {
    return HeroRpg(
      name: name,
      job: job,
      baseHp: baseHp + (n * 10),
      baseMp: baseMp + (n * 5),
      inventory: inventory,
    );
  }

  HeroRpg heal(int amount) {
    return HeroRpg(
      name: name,
      job: job,
      baseHp: baseHp + amount,
      baseMp: baseMp,
      inventory: inventory,
    );
  }

  HeroRpg addItem(String itemName) {
    final newInventory = Map<String, int>.from(inventory);
    newInventory[itemName] = (newInventory[itemName] ?? 0) + 1;
    return HeroRpg(
      name: name,
      job: job,
      baseHp: baseHp,
      baseMp: baseMp,
      inventory: newInventory,
    );
  }

  factory HeroRpg.fromJson(Map<String, dynamic> json) {
    return HeroRpg(
      name: json['name'] as String,
      job: Job.values.firstWhere((e) => e.name == json['job']),
      baseHp: json['baseHp'] as int,
      baseMp: json['baseMp'] as int,
      inventory: {},
    );
  }

  @override
  String toString() => 'Hero(name: $name, hp: $baseHp, mp: $baseMp)';
} 