class FarmingTip {
  final String id;
  final String titleEn;
  final String titleSw;
  final String contentEn;
  final String contentSw;
  final String category;

  const FarmingTip({
    required this.id,
    required this.titleEn,
    required this.titleSw,
    required this.contentEn,
    required this.contentSw,
    required this.category,
  });

  String getTitle(String locale) => locale == 'sw' ? titleSw : titleEn;
  String getContent(String locale) => locale == 'sw' ? contentSw : contentEn;
}

class FarmingTipsDatabase {
  static const List<FarmingTip> tips = [
    FarmingTip(
      id: 'tip1',
      titleEn: 'Early Morning Spraying',
      titleSw: 'Kunywa Mapema Asubuhi',
      contentEn: 'Spray your crops early in the morning when its cool. This helps the solution stick better and reduces evaporation.',
      contentSw: 'Mimina mimea yako mapema asubuhi ukiwa na baridi. Hii husaidia suluhisho liambatte vizuri na kupunguza uyevu.',
      category: 'Disease Prevention',
    ),
    FarmingTip(
      id: 'tip2',
      titleEn: 'Proper Plant Spacing',
      titleSw: 'Nafasi Sahihi ya Mimea',
      contentEn: 'Give your plants enough space to grow. Proper spacing improves air circulation and reduces fungal diseases.',
      contentSw: 'Toa nafasi ya kutosha kwa mimea yako kukua. Nafasi sahihi huboresha mzunguko wa hewa na kupunguza magonjwa ya kuvu.',
      category: 'General',
    ),
    FarmingTip(
      id: 'tip3',
      titleEn: 'Remove Infected Leaves',
      titleSw: 'Ondoa Majani Yaliyoambukizwa',
      contentEn: 'Remove and destroy infected leaves immediately to prevent disease from spreading to the rest of the plant.',
      contentSw: 'Ondoa na uangamize majani yaliyoambukizwa mara moja kuzuia ugonjwa kueneza kwenye sehemu nyingine ya mimea.',
      category: 'Disease Prevention',
    ),
    FarmingTip(
      id: 'tip4',
      titleEn: 'Water at Soil Level',
      titleSw: 'Mimina Maji kwenye Udongo',
      contentEn: 'Water your plants at the base, not on the leaves. Wet leaves can lead to fungal infections.',
      contentSw: 'Mimina maji kwenye shina, si kwenye majani. Majani yaliyo na maji yanaweza kusababisha maambukizi ya kuvu.',
      category: 'Watering',
    ),
    FarmingTip(
      id: 'tip5',
      titleEn: 'Crop Rotation',
      titleSw: 'Mabadiliko ya Mazao',
      contentEn: 'Rotate your crops each season. This helps prevent soil-borne diseases and improves soil health.',
      contentSw: 'Badilisha mazao yako kila majira. Hii husaidia kuzuia magonjwa ya udongo na kuboresha afya ya udongo.',
      category: 'Soil Health',
    ),
    FarmingTip(
      id: 'tip6',
      titleEn: 'Use Organic Mulch',
      titleSw: 'Tumia Mulchi ya Kiorgani',
      contentEn: 'Apply organic mulch around your plants. It retains moisture, adds nutrients, and prevents soil splash.',
      contentSw: 'Tumia mulchi ya kiorgani karibu na mimea yako. Huhifadhi unyevu, ongeza lishe, na zuia kunyesha kwa udongo.',
      category: 'Soil Health',
    ),
    FarmingTip(
      id: 'tip7',
      titleEn: 'Monitor Regularly',
      titleSw: 'Chunguza Mara kwa Mara',
      contentEn: 'Check your plants every day for signs of disease or pests. Early detection leads to easier treatment.',
      contentSw: 'Chunguza mimea yako kila siku kwa alama za ugonjwa au wadudu. Kugundua mapema humaidia matibabu rahisi.',
      category: 'Monitoring',
    ),
    FarmingTip(
      id: 'tip8',
      titleEn: 'Balanced Fertilization',
      titleSw: 'Ruzuku ya Kulinganishwa',
      contentEn: 'Use the right amount of fertilizer. Too much nitrogen can actually attract pests and cause problems.',
      contentSw: 'Tumia kiwango sahihi cha ruzuku. Nitrogeni nyingi inaweza kuwavuta wadudu na kusababisha matatizo.',
      category: 'Nutrition',
    ),
    FarmingTip(
      id: 'tip9',
      titleEn: 'Companion Planting',
      titleSw: 'Kupanda Mimea ya Kando',
      contentEn: 'Plant certain crops together to naturally repel pests. For example, basil with tomatoes helps repel whiteflies.',
      contentSw: 'Panda mazao fulani pamoja kuwavuta wadudu asili. Kwa mfano, basil na nyanya husaidia kuwavuta vimelea meupe.',
      category: 'Pest Control',
    ),
    FarmingTip(
      id: 'tip10',
      titleEn: 'Sanitize Your Tools',
      titleSw: 'Safisha Vyako vya Kilimo',
      contentEn: 'Clean your farming tools regularly. Dirty tools can spread diseases from one plant to another.',
      contentSw: 'Safisha vyako vya kilimo mara kwa mara. Vifaa vy dirty vinaweza kueneza magonjwa kutoka kwa mimea moja hadi nyingine.',
      category: 'Disease Prevention',
    ),
    FarmingTip(
      id: 'tip11',
      titleEn: 'Weed Control',
      titleSw: 'Kudhibiti Magugu',
      contentEn: 'Keep your field weed-free. Weeds compete for nutrients and can harbor pests and diseases.',
      contentSw: 'Shikilia shamba lako lisilo na magugu. Magugu hushindana kwa lishe na kukopesha wadudu na magonjwa.',
      category: 'General',
    ),
    FarmingTip(
      id: 'tip12',
      titleEn: 'Harvest Properly',
      titleSw: 'Vuna Vizuri',
      contentEn: 'Harvest your crops at the right time. Proper harvesting prevents disease and ensures better storage.',
      contentSw: 'Vuna mazao yako kwa wakati sahihi. Kuvuna vizuri kunazuia ugonjwa na kuhakikisha uhifadhi bora.',
      category: 'Harvesting',
    ),
  ];

  static List<FarmingTip> getTipsByCategory(String category) {
    return tips.where((t) => t.category == category).toList();
  }

  static List<String> get categories {
    return tips.map((t) => t.category).toSet().toList();
  }

  static FarmingTip getRandomTip() {
    final index = DateTime.now().millisecond % tips.length;
    return tips[index];
  }
}
