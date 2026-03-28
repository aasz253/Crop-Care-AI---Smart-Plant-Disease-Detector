import 'dart:io';
import 'package:uuid/uuid.dart';
import '../datasources/database_helper.dart';
import '../datasources/ml_service.dart';
import '../models/disease_info.dart';
import '../models/scan_result.dart';

class ScanRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final MLService _mlService = MLService.instance;
  final Uuid _uuid = const Uuid();

  Future<void> initialize() async {
    await _mlService.loadModel();
  }

  Future<ScanResult> analyzeImage(File imageFile, String locale) async {
    // Run ML prediction
    final prediction = await _mlService.predictDisease(imageFile);
    
    final diseaseId = prediction['diseaseId'] as String;
    final confidence = prediction['confidence'] as double;
    final isOffline = prediction['isOffline'] as bool;

    // Get disease info
    final diseaseInfo = DiseaseDatabase.getDiseaseById(diseaseId) ??
        DiseaseDatabase.diseases.last;

    // Create scan result
    final result = ScanResult(
      id: _uuid.v4(),
      imagePath: imageFile.path,
      cropType: diseaseInfo.cropType,
      diseaseId: diseaseId,
      diseaseName: diseaseInfo.getName(locale),
      confidence: confidence,
      treatment: diseaseInfo.getTreatmentSteps(locale).join('\n'),
      cause: diseaseInfo.getCause(locale),
      timestamp: DateTime.now(),
      isOffline: isOffline,
    );

    // Save to database
    await _dbHelper.insertScanResult(result);

    return result;
  }

  Future<List<ScanResult>> getScanHistory() async {
    return await _dbHelper.getAllScanResults();
  }

  Future<void> deleteScanResult(String id) async {
    await _dbHelper.deleteScanResult(id);
  }

  Future<void> clearHistory() async {
    await _dbHelper.deleteAllScanResults();
  }

  Future<int> getScanCount() async {
    return await _dbHelper.getScanCount();
  }

  DiseaseInfo? getDiseaseInfo(String diseaseId) {
    return DiseaseDatabase.getDiseaseById(diseaseId);
  }
}
