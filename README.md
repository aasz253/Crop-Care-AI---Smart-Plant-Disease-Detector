# CropCare AI - Smart Plant Disease Detector

A production-ready Flutter mobile application that helps African farmers detect plant diseases using AI by simply taking a photo of a plant leaf.

## Features

| Feature | Description |
|---------|-------------|
| 📸 Image Capture | Take photos with camera or select from gallery |
| 🤖 AI Detection | Instant disease identification using TensorFlow Lite |
| 🌿 Treatment | Detailed causes, treatments, and prevention tips |
| 📴 Offline Mode | Works without internet using local ML model |
| 🌐 Multi-language | English and Swahili support |
| 🔊 Voice Output | Text-to-speech for results |
| 💾 History | Track your plant scans over time |

## Supported Crops & Diseases

- **Tomato**: Leaf Blight, Leaf Curl Virus, Bacterial Spot
- **Potato**: Late Blight, Blackleg  
- **Maize**: Leaf Blight, Rust
- **Coffee**: Leaf Rust
- **Healthy Plant** detection

---

## Quick Start

### 1. Install Flutter

```bash
# Windows (PowerShell)
iwr https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip -OutFile flutter.zip
Expand-Archive flutter.zip -DestinationPath C:\Flutter
$env:PATH += ";C:\Flutter\bin"

# macOS
brew install flutter

# Linux
git clone https://github.com/flutter/flutter.git -b stable ~/flutter
export PATH="$PATH:$HOME/flutter/bin"
```

### 2. Run the App

```bash
# Navigate to project
cd cropcare_ai

# Get dependencies
flutter pub get

# Run debug build
flutter run
```

---

## Building APK

```bash
# Debug APK
flutter build apk --debug

# Release APK (recommended for distribution)
flutter build apk --release --obfuscate --split-per-abi
```

The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

---

## Adding TensorFlow Lite Model

The app includes a **mock prediction system** for demo purposes. To add real disease detection:

1. **Train a model** using PlantVillage dataset
2. **Convert to TFLite** format
3. **Place** `plant_disease_model.tflite` in `assets/models/`
4. **Add labels** in `assets/models/labels.txt`

The ML service is already configured in `lib/data/datasources/ml_service.dart`.

---

## Project Architecture

```
lib/
├── core/
│   ├── constants/     # App constants, colors, strings
│   └── theme/          # Material 3 theme configuration
├── data/
│   ├── datasources/    # SQLite database, ML service
│   ├── models/         # Disease info, scan results, tips
│   └── repositories/   # Data access layer
├── l10n/              # English & Swahili translations
└── presentation/
    ├── providers/      # Provider state management
    ├── screens/        # Splash, Onboarding, Home, Result
    └── widgets/        # Reusable UI components
```

---

## Technology Stack

- **Flutter 3.x** - UI Framework
- **Provider** - State Management
- **TensorFlow Lite** - Offline ML inference
- **SQLite** - Local data persistence
- **Flutter TTS** - Text-to-speech

---

## Screens

1. **Splash** - Animated logo screen
2. **Onboarding** - 3-step tutorial
3. **Home** - Main scan options
4. **Camera** - Photo capture
5. **Result** - Disease info with treatment
6. **History** - Saved scans
7. **Tips** - Farming advice
8. **Settings** - Language, voice, offline mode

---

## Demo Mode

The app works in **demo mode** without a TFLite model:
- Generates mock predictions based on timestamp
- Shows realistic confidence levels
- All UI features fully functional

---

## License

MIT License

---

## Built for African Farmers 🌱
