import 'dart:io';

class MLService {
  static final MLService instance = MLService._();
  bool _isModelLoaded = false;

  MLService._();

  bool get isModelLoaded => _isModelLoaded;

  Future<void> loadModel() async {
    _isModelLoaded = true;
  }

  Future<Map<String, dynamic>> predictDisease(File imageFile) async {
    return _getMockPrediction(imageFile);
  }

  String _getDiseaseIdFromIndex(int index) {
    const diseaseIds = [
      'tomato_blight',
      'tomato_leaf_curl',
      'tomato_bacterial_spot',
      'potato_blight',
      'potato_blackleg',
      'maize_blight',
      'maize_rust',
      'coffee_rust',
      'healthy',
    ];
    
    if (index >= 0 && index < diseaseIds.length) {
      return diseaseIds[index];
    }
    return 'healthy';
  }

  Map<String, dynamic> _getMockPrediction(File imageFile) {
    final diseases = [
      'tomato_blight',
      'tomato_leaf_curl',
      'tomato_bacterial_spot',
      'potato_blight',
      'potato_blackleg',
      'maize_blight',
      'maize_rust',
      'coffee_rust',
      'healthy',
    ];

    final randomIndex = DateTime.now().millisecond % diseases.length;
    final confidence = 0.7 + (DateTime.now().second % 30) / 100;

    return {
      'diseaseId': diseases[randomIndex],
      'confidence': confidence.clamp(0.0, 0.99),
      'isOffline': true,
    };
  }

  void dispose() {
    _isModelLoaded = false;
  }
}
