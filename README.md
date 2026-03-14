# Sinport Airport UI – High-End Flutter Implementation

A premium, high-fidelity Flutter UI project inspired by modern airport navigation and service applications. This implementation focuses on "ultra-quality" code, fluid animations, and a seamless user experience.

## ✨ Key Features

### 🏠 Home Dashboard
- **Dynamic Service Grid**: A unique, alternating grid layout (Wide-Small, Small-Wide) for services like Transfer, Tickets, and Car Rent.
- **Micro-Animations**: All interactive cards feature smooth scale transitions and haptic feedback on touch.
- **Flight Overview**: Clean typography for upcoming departures with gate information and quick-action links.

### 🗺️ Smart Map & Navigation
- **3D-Simulated Map View**: A dark-themed, perspective-based map with interactive 3D elements.
- **Advanced Search Experience**: 
  - Real-time filtering of airport locations.
  - Smooth "iOS-style" bottom sheet transitions.
  - Recent search history with distance indicators.
- **Live Navigation Mode**: 
  - Dynamic top banner for turn-by-turn directions.
  - Real-time stats card showing Arrival Time, Distance, and Duration.
- **Layered Controls**: Interactive floor level switcher (2, 1, -1) and zoom controls.

### 🎨 Design & Animation
- **Bouncy Interactions**: Custom `BouncyButton` component providing consistent spring-back effects and haptic impact across the entire app.
- **Safe Animations**: Use of clamped `TweenAnimationBuilder` to ensure smooth opacity and transform transitions without assertion errors.
- **Premium Color Palette**: Deep navy backgrounds, high-contrast white surfaces, and "Sinport Yellow" accents.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Android Studio / VS Code
- An emulator or physical device (iOS/Android)

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/sinport_flutter.git
   ```
2. Navigate to the project directory:
   ```bash
   cd sinport_flutter
   ```
3. Get dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## 📂 Project Structure

```text
lib/
├── main.dart             # App entry point
├── screens/
│   ├── home_screen.dart     # Main scaffold & bottom nav
│   ├── home_content.dart    # Dashboard / Home content
│   └── map_screen.dart      # Complex map & navigation logic
├── widgets/
│   ├── bouncy_button.dart   # Ultra-quality animation component
│   ├── service_button.dart  # Grid service buttons
│   ├── departure_card.dart  # Flight information cards
│   └── bottom_nav.dart      # Custom animated navigation bar
```

## 🛠️ Built With
- **Flutter**: The UI framework.
- **HapticFeedback**: For tactile user responses.
- **Custom Painters**: For map view-cone and specialized UI elements.
- **Implicit Animations**: For fluid UI state transitions.

---
*Created with a focus on premium performance and pixel-perfect design.*
