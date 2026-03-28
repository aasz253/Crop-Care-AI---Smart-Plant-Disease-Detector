class DiseaseInfo {
  final String id;
  final String nameEn;
  final String nameSw;
  final String cropType;
  final String causeEn;
  final String causeSw;
  final List<String> treatmentStepsEn;
  final List<String> treatmentStepsSw;
  final List<String> organicSolutionsEn;
  final List<String> organicSolutionsSw;
  final List<String> pesticides;
  final List<String> preventionTipsEn;
  final List<String> preventionTipsSw;
  final double confidenceThreshold;

  const DiseaseInfo({
    required this.id,
    required this.nameEn,
    required this.nameSw,
    required this.cropType,
    required this.causeEn,
    required this.causeSw,
    required this.treatmentStepsEn,
    required this.treatmentStepsSw,
    required this.organicSolutionsEn,
    required this.organicSolutionsSw,
    required this.pesticides,
    required this.preventionTipsEn,
    required this.preventionTipsSw,
    this.confidenceThreshold = 0.6,
  });

  String getName(String locale) => locale == 'sw' ? nameSw : nameEn;
  String getCause(String locale) => locale == 'sw' ? causeSw : causeEn;
  List<String> getTreatmentSteps(String locale) =>
      locale == 'sw' ? treatmentStepsSw : treatmentStepsEn;
  List<String> getPreventionTips(String locale) =>
      locale == 'sw' ? preventionTipsSw : preventionTipsEn;
  List<String> getOrganicSolutions(String locale) =>
      locale == 'sw' ? organicSolutionsSw : organicSolutionsEn;
}

class DiseaseDatabase {
  static const List<DiseaseInfo> diseases = [
    // Tomato Diseases
    DiseaseInfo(
      id: 'tomato_blight',
      nameEn: 'Tomato Leaf Blight',
      nameSw: 'Ugavi wa Majani ya Nyanya',
      cropType: 'Tomato',
      causeEn: 'Caused by the fungus Phytophthora infestans. Spread through wet conditions and high humidity.',
      causeSw: 'Ingoshwa na kuvu Phytophthora infestans. Ineneza kwa hali ya unyevu na uvimbi wa juu.',
      treatmentStepsEn: [
        'Remove infected leaves immediately',
        'Apply copper-based fungicide',
        'Improve air circulation around plants',
        'Avoid overhead watering',
        'Apply mulch to prevent soil splash',
      ],
      treatmentStepsSw: [
        'Ondoa majani yaliyoambukizwa mara moja',
        'Weka dawa ya kupambana na vimelea ya copper',
        'Boresha mzunguko wa hewa karibu na mimea',
        ' Epuka kunywa maji kutoka juu',
        'Weka mulchi kuzuia kunyesha kwa udongo',
      ],
      organicSolutionsEn: [
        'Neem oil spray (5ml per liter water)',
        'Baking soda solution (1 tbsp per gallon)',
        'Copper soap fungicide',
        'Compost tea spray',
      ],
      organicSolutionsSw: [
        'Sprei ya mafuta ya neem (5ml kwa litre ya maji)',
        'Sulfuri ya bicarbonate (1 tbsp kwa galoni)',
        'Dawa ya kupambana na vimelea ya sabuni ya copper',
        'Sprei ya chai ya komposti',
      ],
      pesticides: ['Copper Fungicide', 'Mancozeb', 'Chlorothalonil'],
      preventionTipsEn: [
        'Plant resistant varieties',
        'Space plants properly for airflow',
        'Water at soil level, not on leaves',
        'Remove plant debris',
        'Rotate crops every 2-3 years',
      ],
      preventionTipsSw: [
        'Panda aina zinazostahimili',
        'Space mimea vizuri kwa mtiririko wa hewa',
        'Mimina maji kwenye udongo, si kwenye majani',
        'Ondoa takataka za mimea',
        'Badilisha mazao kila miaka 2-3',
      ],
    ),
    DiseaseInfo(
      id: 'tomato_leaf_curl',
      nameEn: 'Tomato Leaf Curl Virus',
      nameSw: 'Virusi vya Kuguruma kwa Majani ya Nyanya',
      cropType: 'Tomato',
      causeEn: 'Caused by begomovirus, transmitted by whiteflies. Also caused by heat stress and drought.',
      causeSw: 'Ingoshwa na begomovirus, inenezwa na vimelea meupe. Pia inasababishwa na joto na ukame.',
      treatmentStepsEn: [
        'Control whitefly population',
        'Remove infected plants immediately',
        'Use reflective mulch to repel whiteflies',
        'Apply insecticidal soap',
        'Provide adequate water to reduce stress',
      ],
      treatmentStepsSw: [
        'Dhibiti idadi ya vimelea meupe',
        'Ondoa mimea iliyoambukizwa mara moja',
        'Tumia mulchi ya kioo kuwavuta vimelea meupe',
        'Tumia sabuni ya kuua wadudu',
        'Toa maji ya kutosha kupunguza ms stress',
      ],
      organicSolutionsEn: [
        'Neem oil for whitefly control',
        'Yellow sticky traps',
        'Garlic spray',
        'Companion planting with basil',
      ],
      organicSolutionsSw: [
        'Mafuta ya neem kudhibiti vimelea meupe',
        'Meteo ya manjano ya kushikamana',
        'Sprei ya vitunguu',
        'Kupanda mimea ya kando na basil',
      ],
      pesticides: ['Imidacloprid', 'Acetamiprid', 'Thiamethoxam'],
      preventionTipsEn: [
        'Use insect-proof netting',
        'Remove weeds that host whiteflies',
        'Avoid planting near infected crops',
        'Monitor plants regularly',
        'Use resistant varieties',
      ],
      preventionTipsSw: [
        'Tumia wavu ya kuzuia wadudu',
        'Ondoa magugu yanayokopesha vimelea meupe',
        'Epuka kupanda karibu na mimea iliyoambukizwa',
        'Chunguza mimea mara kwa mara',
        'Tumia aina zinazostahimili',
      ],
    ),
    DiseaseInfo(
      id: 'tomato_bacterial_spot',
      nameEn: 'Bacterial Spot',
      nameSw: 'Kidoa cha Bacterial',
      cropType: 'Tomato',
      causeEn: 'Caused by Xanthomonas bacteria. Spreads through contaminated seeds, water, and handling.',
      causeSw: 'Ingoshwa na bacteria Xanthomonas. Ineneza kupitia mbili zilizoambukizwa, maji, na kushika.',
      treatmentStepsEn: [
        'Remove infected leaves',
        'Apply copper bactericide',
        'Avoid working with wet plants',
        'Improve plant spacing',
        'Remove plant debris',
      ],
      treatmentStepsSw: [
        'Ondoa majani yaliyoambukizwa',
        'Tumia dawa ya copper ya kuua bacteria',
        'Epuka kushika mimea iliyo na maji',
        'Boresha nafasi ya mimea',
        'Ondoa takataka za mimea',
      ],
      organicSolutionsEn: [
        'Copper-based organic spray',
        'Hydrogen peroxide solution',
        'Baking soda spray',
      ],
      organicSolutionsSw: [
        'Sprei ya kiorgani ya copper',
        'Sulfuri ya hidrojeni ya oksidi',
        'Sprei ya bicarbonate ya soda',
      ],
      pesticides: ['Copper hydroxide', 'Copper sulfate', 'Streptomycin'],
      preventionTipsEn: [
        'Use disease-free seeds',
        'Rotate crops',
        'Avoid overhead irrigation',
        'Remove infected plants promptly',
      ],
      preventionTipsSw: [
        'Tumia mbili zisizo na ugonjwa',
        'Badilisha mazao',
        'Epuka kunywa maji kutoka juu',
        'Ondoa mimea iliyoambukizwa haraka',
      ],
    ),
    // Potato Diseases
    DiseaseInfo(
      id: 'potato_blight',
      nameEn: 'Potato Late Blight',
      nameSw: 'Ugavi wa Kuchelewa kwa Viazi',
      cropType: 'Potato',
      causeEn: 'Caused by Phytophthora infestans. Spreads rapidly in cool, wet conditions.',
      causeSw: 'Ingoshwa na Phytophthora infestans. Ineneza haraka kwa hali ya baridi na unyevu.',
      treatmentStepsEn: [
        'Remove and destroy infected plants',
        'Apply fungicide immediately',
        'Improve drainage',
        'Hill up soil around plants',
        'Harvest tubers in dry conditions',
      ],
      treatmentStepsSw: [
        'Ondoa na uangamize mimea iliyoambukizwa',
        'Tumia dawa ya kupambana na vimelea mara moja',
        'Boresha mto',
        'Chukua udongo karibu na mimea',
        'Vuna tubercles kwa hali ya kavu',
      ],
      organicSolutionsEn: [
        'Copper fungicide',
        'Baking soda spray',
        'Neem oil',
        'Compost tea',
      ],
      organicSolutionsSw: [
        'Dawa ya copper',
        'Sprei ya bicarbonate ya soda',
        'Mafuta ya neem',
        'Chai ya komposti',
      ],
      pesticides: ['Mancozeb', 'Metalaxyl', 'Chlorothalonil'],
      preventionTipsEn: [
        'Use certified seed potatoes',
        'Choose resistant varieties',
        'Hill up soil properly',
        'Avoid overhead irrigation',
        'Destroy volunteer plants',
      ],
      preventionTipsSw: [
        'Tumia mbili za viazi zilizoidhinishwa',
        'Chagua aina zinazostahimili',
        'Chukua udongo vizuri',
        'Epuka kunywa maji kutoka juu',
        'Angamiza mimea ya kujitokeza',
      ],
    ),
    DiseaseInfo(
      id: 'potato_blackleg',
      nameEn: 'Potato Blackleg',
      nameSw: 'Mguu Mweusi wa Viazi',
      cropType: 'Potato',
      causeEn: 'Caused by Pectobacterium bacteria. Enters through wounds and spreads in wet conditions.',
      causeSw: 'Ingoshwa na bacteria Pectobacterium. Ingia kupitia jeraha na ineneza kwa hali ya unyevu.',
      treatmentStepsEn: [
        'Remove infected plants immediately',
        'Improve field drainage',
        'Cut away rotting tissue',
        'Allow cuts to dry before planting',
        'Rotate to non-host crops',
      ],
      treatmentStepsSw: [
        'Ondoa mimea iliyoambukizwa mara moja',
        'Boresha mto wa shamba',
        'Kata tishu zilizoanguka',
        'Ruhusu makato kukauka kabla ya kupanda',
        'Badilisha na mimea isiyokubali',
      ],
      organicSolutionsEn: [
        'Good drainage management',
        'Proper curing of seed potatoes',
        'Soil solarization',
      ],
      organicSolutionsSw: [
        'Usimamizi mzuri wa mto',
        'Kuhifadhi vizuri mbili za viazi',
        'Solarization ya udongo',
      ],
      pesticides: ['Copper-based products'],
      preventionTipsEn: [
        'Use certified seed',
        'Plant in well-drained soil',
        'Avoid injury to tubers',
        'Rotate crops',
        'Remove infected plants promptly',
      ],
      preventionTipsSw: [
        'Tumia mbili zilizoidhinishwa',
        'Panda kwenye udongo wenye mkusanyiko mzuri',
        'Epuka jeraha kwa tubercles',
        'Badilisha mazao',
        'Ondoa mimea iliyoambukizwa haraka',
      ],
    ),
    // Maize Diseases
    DiseaseInfo(
      id: 'maize_blight',
      nameEn: 'Maize Leaf Blight',
      nameSw: 'Ugavi wa Majani ya Mahindi',
      cropType: 'Maize',
      causeEn: 'Caused by Exserohilum fungus. Spreads through wind-blown spores and crop residue.',
      causeSw: 'Ingoshwa na kuvu Exserohilum. Ineneza kupitia spores za upepo na takataka za mazao.',
      treatmentStepsEn: [
        'Apply foliar fungicide',
        'Remove infected leaves',
        'Improve plant spacing',
        'Remove crop residue',
        'Adjust planting density',
      ],
      treatmentStepsSw: [
        'Tumia dawa ya majani',
        'Ondoa majani yaliyoambukizwa',
        'Boresha nafasi ya mimea',
        'Ondoa takataka za mazao',
        'Rekebisha msongamano wa kupanda',
      ],
      organicSolutionsEn: [
        'Neem oil spray',
        'Baking soda solution',
        'Compost tea',
        'Corn silk tea',
      ],
      organicSolutionsSw: [
        'Sprei ya mafuta ya neem',
        'Sulfuri ya bicarbonate ya soda',
        'Chai ya komposti',
        'Chai ya nyuzi ya mahindi',
      ],
      pesticides: ['Azoxystrobin', 'Pyraclostrobin', 'Propiconazole'],
      preventionTipsEn: [
        'Use resistant hybrids',
        'Rotate with non-grass crops',
        'Plow under residue',
        'Balanced fertilization',
        'Early planting',
      ],
      preventionTipsSw: [
        'Tumia vichanganyiko vinavyostahimili',
        'Badilisha na mimea isiyo ya nyasi',
        'Chapa chini takataka',
        'Ruzuku ya kulinganishwa',
        'Kupanda mapema',
      ],
    ),
    DiseaseInfo(
      id: 'maize_rust',
      nameEn: 'Maize Rust',
      nameSw: 'Chai ya Mahindi',
      cropType: 'Maize',
      causeEn: 'Caused by Puccinia fungus. Appears as orange-brown pustules on leaves.',
      causeSw: 'Ingoshwa na kuvu Puccinia. Inaonyonyoka kama pustules ya kahawa-kijani kwenye majani.',
      treatmentStepsEn: [
        'Apply fungicide at first sign',
        'Remove heavily infected leaves',
        'Ensure good air circulation',
        'Avoid excessive nitrogen',
        'Monitor adjacent crops',
      ],
      treatmentStepsSw: [
        'Tumia dawa ya kupambana na vimelea kwa alama ya kwanza',
        'Ondoa majani yaliyoambukizwa sana',
        'Hakikisha mzunguko mzuri wa hewa',
        'Epuka nitrogeni nyingi',
        'Chunguza mimea ya jirani',
      ],
      organicSolutionsEn: [
        'Sulfur-based fungicides',
        'Neem oil',
        'Baking soda spray',
        'Herbal teas',
      ],
      organicSolutionsSw: [
        'Dawa ya k基础 ya sulfur',
        'Mafuta ya neem',
        'Sprei ya bicarbonate ya soda',
        'Maitungwa ya miti',
      ],
      pesticides: ['Triazoles', 'Strobilurins', 'Copper fungicides'],
      preventionTipsEn: [
        'Plant early maturing varieties',
        'Use resistant varieties',
        'Balanced nutrition',
        'Remove infected debris',
        'Scout regularly',
      ],
      preventionTipsSw: [
        'Panda aina za kuchakata mapema',
        'Tumia aina zinazostahimili',
        'Lishe ya kulinganishwa',
        'Ondoa takataka zilizoambukizwa',
        'Chunguza mara kwa mara',
      ],
    ),
    // Coffee Diseases
    DiseaseInfo(
      id: 'coffee_rust',
      nameEn: 'Coffee Leaf Rust',
      nameSw: 'Chai ya Majani ya Kahawa',
      cropType: 'Coffee',
      causeEn: 'Caused by Hemileia vastatrix fungus. Creates orange-yellow powder on leaf undersides.',
      causeSw: 'Ingoshwa na kuvu Hemileia vastatrix. Inaunda chembechembe ya njano-zambarau kwenye chini ya majani.',
      treatmentStepsEn: [
        'Apply systemic fungicide',
        'Remove infected leaves',
        'Shade management',
        'Improve air circulation',
        'Apply copper-based products',
      ],
      treatmentStepsSw: [
        'Tumia dawa ya mfumo',
        'Ondoa majani yaliyoambukizwa',
        'Usimamizi wa kivuli',
        'Boresha mzunguko wa hewa',
        'Tumia bidhaa za copper',
      ],
      organicSolutionsEn: [
        'Copper-based organic fungicides',
        'Bordeaux mixture',
        'Neem oil',
        'Sulfur',
      ],
      organicSolutionsSw: [
        'Dawa ya kiorgani ya copper',
        'Mchanganyiko wa Bordeaux',
        'Mafuta ya neem',
        'Sulfuri',
      ],
      pesticides: ['Triazoles', 'Strobilurins', 'Copper oxychloride'],
      preventionTipsEn: [
        'Use resistant varieties',
        'Proper shade management',
        'Regular monitoring',
        'Balanced fertilization',
        'Remove alternate hosts',
      ],
      preventionTipsSw: [
        'Tumia aina zinazostahimili',
        'Usimamizi sahihi wa kivuli',
        'Kuchunguza mara kwa mara',
        'Lishe ya kulinganishwa',
        'Ondoa v.host vya mbadala',
      ],
    ),
    // Healthy
    DiseaseInfo(
      id: 'healthy',
      nameEn: 'Healthy Plant',
      nameSw: 'Mimea ya Afya',
      cropType: 'General',
      causeEn: 'Your plant appears healthy! Continue with good agricultural practices.',
      causeSw: 'Mimea yako inaonekana ya afya! Endelea na mazoea bora ya kilimo.',
      treatmentStepsEn: [
        'Continue regular watering',
        'Maintain balanced nutrition',
        'Monitor for pests regularly',
        'Keep area weed-free',
      ],
      treatmentStepsSw: [
        'Endelea kunywa maji kawaida',
        'Shikilia lishe iliyosawazishwa',
        'Chunguza wadudu mara kawaida',
        'Shikilia eneo lisilo na magugu',
      ],
      organicSolutionsEn: [
        'Compost for nutrition',
        'Mulching to retain moisture',
        'Companion planting',
      ],
      organicSolutionsSw: [
        'Komposti kwa lishe',
        'Mulchi kuhifadhi unyevu',
        'Kupanda mimea ya kando',
      ],
      pesticides: [],
      preventionTipsEn: [
        'Regular watering schedule',
        'Proper fertilization',
        'Pest monitoring',
        'Crop rotation',
      ],
      preventionTipsSw: [
        'Ratibu ya kunywa maji',
        'Ruzuku sahihi',
        'Uchunguzi wa wadudu',
        'Mabadiliko ya mazao',
      ],
    ),
  ];

  static DiseaseInfo? getDiseaseById(String id) {
    try {
      return diseases.firstWhere((d) => d.id == id);
    } catch (e) {
      return null;
    }
  }

  static DiseaseInfo? getDiseaseByName(String name) {
    try {
      final lowerName = name.toLowerCase();
      return diseases.firstWhere(
        (d) => d.nameEn.toLowerCase().contains(lowerName) ||
               d.nameSw.toLowerCase().contains(lowerName) ||
               d.id.toLowerCase().contains(lowerName),
      );
    } catch (e) {
      return diseases.last; // Return healthy as default
    }
  }

  static List<String> get cropTypes {
    return diseases.map((d) => d.cropType).toSet().toList()..sort();
  }
}
