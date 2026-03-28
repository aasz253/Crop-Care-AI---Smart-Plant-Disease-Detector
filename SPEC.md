# CropCare AI - Smart Plant Disease Detector

## 1. Project Overview

**Project Name:** CropCare AI  
**Type:** Flutter Mobile Application (Android)  
**Core Functionality:** AI-powered plant disease detection app that allows farmers to photograph crop leaves and receive instant disease diagnosis with treatment recommendations, working offline with TensorFlow Lite.

---

## 2. Technology Stack & Choices

### Framework & Language
- **Flutter SDK:** 3.x (latest stable)
- **Dart:** 3.x
- **Target Platform:** Android (API 21+)

### Key Libraries/Dependencies
| Category | Package | Purpose |
|----------|---------|---------|
| State Management | `provider` | App-wide state management |
| Local Storage | `sqflite` + `path` | SQLite database for history |
| Camera | `camera` | Native camera access |
| Image Picker | `image_picker` | Gallery selection |
| HTTP | `http` | API calls for cloud ML |
| TensorFlow | `tflite_flutter` | Offline ML inference |
| Image Processing | `image` | Image compression |
| Localization | `flutter_localizations` + `intl` | i18n (EN/SW) |
| Text-to-Speech | `flutter_tts` | Voice output |
| Permissions | `permission_handler` | Runtime permissions |
| Path Provider | `path_provider` | Local file storage |
| UUID | `uuid` | Unique identifiers |

### State Management Approach
- **Provider** for simplicity and performance on low-end devices
- Clean separation: UI → Provider → Repository → Data Source

### Architecture Pattern
- **Clean Architecture** with 3 layers:
  - **Presentation Layer:** Screens, Widgets, Providers
  - **Domain Layer:** Models, Use Cases
  - **Data Layer:** Repositories, Local/Remote Data Sources

---

## 3. Feature List

### Core Features (Must Have)
1. ✅ Splash Screen with app branding
2. ✅ Onboarding screen (3-step tutorial)
3. ✅ Home Screen with main actions
4. ✅ Camera capture for plant leaf photos
5. ✅ Gallery image selection
6. ✅ AI Disease Detection (TensorFlow Lite offline + cloud API fallback)
7. ✅ Disease results with confidence score
8. ✅ Treatment recommendations with causes, steps, solutions
9. ✅ Offline mode with cached results
10. ✅ Scan history with local storage
11. ✅ Multi-language (English/Swahili)
12. ✅ Settings screen with language toggle

### Extra Features (Winning)
1. ✅ Text-to-Speech for results (voice output)
2. ✅ Daily farming tips
3. ✅ Disease prevention advice
4. ✅ Image compression for faster processing

---

## 4. UI/UX Design Direction

### Overall Visual Style
- **Material Design 3** with agricultural theme
- Clean, minimalist, farmer-friendly
- Large touch targets (min 48dp)
- High contrast for outdoor visibility

### Color Scheme
| Role | Color | Hex |
|------|-------|-----|
| Primary | Green (Agriculture) | #2E7D32 |
| Primary Variant | Dark Green | #1B5E20 |
| Secondary | Amber (Warning) | #FFA000 |
| Background | Light Green Tint | #F1F8E9 |
| Surface | White | #FFFFFF |
| Error | Red | #D32F2F |
| Success | Light Green | #4CAF50 |

### Layout Approach
- **Bottom Navigation** for main sections (Home, History, Tips, Settings)
- **Single-page flows** for scanning (Camera → Result)
- Large, clear icons with labels
- Minimal text, maximum visual cues

### Typography
- Large fonts (min 16sp body, 24sp headers)
- Bold headings for quick scanning
- Simple language (avoid technical jargon)

### Accessibility
- Voice feedback for all actions
- High contrast mode support
- Works on low-end devices (1GB RAM)

---

## 5. Disease Database

### Supported Crops & Diseases (Demo Model)
1. **Tomato**
   - Tomato Leaf Blight
   - Tomato Leaf Curl
   - Bacterial Spot
   - Healthy

2. **Potato**
   - Potato Blight
   - Potato Blackleg
   - Healthy

3. **Maize**
   - Maize Leaf Blight
   - Maize Rust
   - Healthy

4. **Coffee**
   - Coffee Leaf Rust
   - Healthy

5. **General**
   - Multiple diseases detected
   - Unknown disease

---

## 6. Data Models

### ScanResult
- id, imagePath, cropType, diseaseName, confidence, treatment, timestamp, isOffline

### DiseaseInfo
- name, causes, treatmentSteps, organicSolutions, pesticides, preventionTips

### Language
- English (en), Swahili (sw)

---

## 7. Offline Strategy

1. Pre-bundle TensorFlow Lite model with app
2. Cache last 50 scan results in SQLite
3. Store disease database locally
4. Queue cloud sync when online
5. Show offline indicator in UI
