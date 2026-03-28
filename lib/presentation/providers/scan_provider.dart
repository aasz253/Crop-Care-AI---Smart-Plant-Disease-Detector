import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import '../../data/models/scan_result.dart';
import '../../data/repositories/scan_repository.dart';

enum ScanState { idle, capturing, analyzing, completed, error }

class ScanProvider extends ChangeNotifier {
  final ScanRepository _repository = ScanRepository();
  final ImagePicker _imagePicker = ImagePicker();

  ScanState _state = ScanState.idle;
  ScanResult? _currentResult;
  String? _errorMessage;
  List<ScanResult> _history = [];
  bool _isLoading = false;

  ScanState get state => _state;
  ScanResult? get currentResult => _currentResult;
  String? get errorMessage => _errorMessage;
  List<ScanResult> get history => _history;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    await _repository.initialize();
    await loadHistory();
  }

  Future<File?> captureImage() async {
    try {
      _state = ScanState.capturing;
      notifyListeners();

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image == null) {
        _state = ScanState.idle;
        notifyListeners();
        return null;
      }

      // Compress and save image
      final compressedFile = await _compressImage(File(image.path));
      return compressedFile;
    } catch (e) {
      _state = ScanState.error;
      _errorMessage = 'Failed to capture image: $e';
      notifyListeners();
      return null;
    }
  }

  Future<File?> pickFromGallery() async {
    try {
      _state = ScanState.capturing;
      notifyListeners();

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image == null) {
        _state = ScanState.idle;
        notifyListeners();
        return null;
      }

      // Compress and save image
      final compressedFile = await _compressImage(File(image.path));
      return compressedFile;
    } catch (e) {
      _state = ScanState.error;
      _errorMessage = 'Failed to pick image: $e';
      notifyListeners();
      return null;
    }
  }

  Future<File> _compressImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);
    
    if (image == null) return imageFile;

    // Resize if too large
    img.Image resized = image;
    if (image.width > 1024 || image.height > 1024) {
      resized = img.copyResize(image, width: 1024);
    }

    // Save to app directory
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'scan_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final newPath = '${appDir.path}/$fileName';
    
    final compressedBytes = img.encodeJpg(resized, quality: 85);
    final newFile = File(newPath);
    await newFile.writeAsBytes(compressedBytes);

    return newFile;
  }

  Future<void> analyzeImage(File imageFile, String locale) async {
    try {
      _state = ScanState.analyzing;
      _errorMessage = null;
      notifyListeners();

      final result = await _repository.analyzeImage(imageFile, locale);
      
      _currentResult = result;
      _state = ScanState.completed;
      
      // Refresh history
      await loadHistory();
      
      notifyListeners();
    } catch (e) {
      _state = ScanState.error;
      _errorMessage = 'Analysis failed: $e';
      notifyListeners();
    }
  }

  Future<void> loadHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      _history = await _repository.getScanHistory();
    } catch (e) {
      _errorMessage = 'Failed to load history: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteFromHistory(String id) async {
    try {
      await _repository.deleteScanResult(id);
      _history.removeWhere((r) => r.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to delete: $e';
      notifyListeners();
    }
  }

  Future<void> clearHistory() async {
    try {
      await _repository.clearHistory();
      _history.clear();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to clear history: $e';
      notifyListeners();
    }
  }

  void reset() {
    _state = ScanState.idle;
    _currentResult = null;
    _errorMessage = null;
    notifyListeners();
  }

  void setError(String message) {
    _state = ScanState.error;
    _errorMessage = message;
    notifyListeners();
  }
}
