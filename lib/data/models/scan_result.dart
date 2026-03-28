import 'dart:convert';

class ScanResult {
  final String id;
  final String imagePath;
  final String cropType;
  final String diseaseId;
  final String diseaseName;
  final double confidence;
  final String treatment;
  final String cause;
  final DateTime timestamp;
  final bool isOffline;

  ScanResult({
    required this.id,
    required this.imagePath,
    required this.cropType,
    required this.diseaseId,
    required this.diseaseName,
    required this.confidence,
    required this.treatment,
    required this.cause,
    required this.timestamp,
    this.isOffline = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'cropType': cropType,
      'diseaseId': diseaseId,
      'diseaseName': diseaseName,
      'confidence': confidence,
      'treatment': treatment,
      'cause': cause,
      'timestamp': timestamp.toIso8601String(),
      'isOffline': isOffline ? 1 : 0,
    };
  }

  factory ScanResult.fromMap(Map<String, dynamic> map) {
    return ScanResult(
      id: map['id'],
      imagePath: map['imagePath'],
      cropType: map['cropType'],
      diseaseId: map['diseaseId'],
      diseaseName: map['diseaseName'],
      confidence: map['confidence'],
      treatment: map['treatment'],
      cause: map['cause'],
      timestamp: DateTime.parse(map['timestamp']),
      isOffline: map['isOffline'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScanResult.fromJson(String source) =>
      ScanResult.fromMap(json.decode(source));

  ScanResult copyWith({
    String? id,
    String? imagePath,
    String? cropType,
    String? diseaseId,
    String? diseaseName,
    double? confidence,
    String? treatment,
    String? cause,
    DateTime? timestamp,
    bool? isOffline,
  }) {
    return ScanResult(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      cropType: cropType ?? this.cropType,
      diseaseId: diseaseId ?? this.diseaseId,
      diseaseName: diseaseName ?? this.diseaseName,
      confidence: confidence ?? this.confidence,
      treatment: treatment ?? this.treatment,
      cause: cause ?? this.cause,
      timestamp: timestamp ?? this.timestamp,
      isOffline: isOffline ?? this.isOffline,
    );
  }
}
