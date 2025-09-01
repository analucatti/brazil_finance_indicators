# Brazil Finance Indicators 🇧🇷 📊

A comprehensive Flutter application for tracking and analyzing Brazilian financial market indicators, providing real-time data and insights for investors and financial analysts.

## 📈 Overview

Brazil Finance Indicators is a mobile application designed to provide easy access to key Brazilian financial market data, including stock market indices, currency rates, inflation metrics, and economic indicators. Built with Flutter for cross-platform compatibility, this app delivers a seamless experience on both iOS and Android devices.

## ✨ Features

### Core Functionality
- **Real-time Market Data**: Track live prices from B3 (Brasil, Bolsa, Balcão)
- **Economic Indicators**: Monitor key Brazilian economic metrics
  - SELIC Rate (Taxa SELIC)
  - IPCA Inflation Index
  - IGP-M Index
  - GDP Growth Rate
  - Unemployment Rate
- **Currency Exchange**: Real-time BRL exchange rates
  - USD/BRL
  - EUR/BRL
  - Other major currency pairs
- **Stock Market Indices**:
  - IBOVESPA
  - IBRX-50
  - Small Cap Index
  - Sector-specific indices
- **Fixed Income Indicators**:
  - CDI Rate
  - Treasury Bonds (Tesouro Direto) rates
  - DI Futures
- **Commodities**: Track Brazilian commodity prices
  - Coffee
  - Sugar
  - Soybeans
  - Iron Ore

### User Features
- 📱 Responsive and intuitive UI/UX
- 🌓 Dark/Light theme support
- 📊 Interactive charts and visualizations
- 🔔 Customizable price alerts
- 💾 Offline data caching
- 🌍 Multi-language support (Portuguese/English)
- 📈 Portfolio tracking capabilities
- 📰 Financial news integration

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
- [Flutter](https://flutter.dev/docs/get-started/install) (3.0.0 or higher)
- [Dart](https://dart.dev/get-dart) (2.17.0 or higher)
- Android Studio / Xcode (for mobile development)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/analucatti/brazil_finance_indicators.git
   cd brazil_finance_indicators
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API keys**
   
   Create a `.env` file in the root directory:
   ```env
   # API Configuration
   API_BASE_URL=your_api_base_url
   API_KEY=your_api_key
   
   # Optional: News API
   NEWS_API_KEY=your_news_api_key
   
   # Optional: Market Data Provider
   MARKET_DATA_KEY=your_market_data_key
   ```

4. **Run the application**
   ```bash
   # For development
   flutter run
   
   # For specific platform
   flutter run -d ios     # iOS
   flutter run -d android # Android
   ```

## 📱 Supported Platforms

- ✅ Android (5.0+)
- ✅ iOS (12.0+)
- 🔄 Web (Coming soon)
- 🔄 Windows/macOS/Linux (Planned)

## 🏗️ Project Structure

```
brazil_finance_indicators/
├── lib/
│   ├── main.dart                 # Application entry point
│   ├── config/                   # Configuration files
│   │   ├── theme.dart
│   │   └── constants.dart
│   ├── models/                   # Data models
│   │   ├── indicator.dart
│   │   ├── currency.dart
│   │   └── stock.dart
│   ├── providers/                # State management (Provider/Riverpod)
│   │   ├── market_provider.dart
│   │   └── settings_provider.dart
│   ├── services/                 # API and data services
│   │   ├── api_service.dart
│   │   ├── cache_service.dart
│   │   └── notification_service.dart
│   ├── screens/                  # UI screens
│   │   ├── home/
│   │   ├── indicators/
│   │   ├── portfolio/
│   │   └── settings/
│   ├── widgets/                  # Reusable widgets
│   │   ├── charts/
│   │   ├── cards/
│   │   └── common/
│   └── utils/                    # Utility functions
│       ├── formatters.dart
│       └── validators.dart
├── assets/                       # Images, fonts, icons
├── test/                         # Unit and widget tests
└── pubspec.yaml                  # Project dependencies
```

## 🔧 Configuration

### API Integration

The app supports multiple data providers. Configure your preferred provider in `lib/config/api_config.dart`:

```dart
class ApiConfig {
  static const String provider = 'YOUR_PROVIDER'; // 'alpha_vantage', 'yahoo_finance', etc.
  static const String baseUrl = 'https://api.example.com';
  static const Duration timeout = Duration(seconds: 30);
}
```

### Customization

Customize the app appearance in `lib/config/theme.dart`:

```dart
final lightTheme = ThemeData(
  primaryColor: Colors.green[700],
  // ... other theme properties
);

final darkTheme = ThemeData(
  primaryColor: Colors.green[400],
  // ... other theme properties
);
```

## 📊 Data Sources

This application integrates with various Brazilian financial data providers:

- **B3 (Brasil, Bolsa, Balcão)**: Official Brazilian stock exchange data
- **Banco Central do Brasil**: Official economic indicators
- **CVM (Comissão de Valores Mobiliários)**: Regulatory data
- **Third-party APIs**: Additional market data and news

## 🧪 Testing

Run the test suite:

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/api_service_test.dart
```

## 📦 Building for Production

### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines

- Follow the [Flutter style guide](https://dart.dev/guides/language/effective-dart/style)
- Write unit tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting PR

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) - UI framework
- [Dart](https://dart.dev/) - Programming language
- [B3](https://www.b3.com.br/) - Brazilian Stock Exchange
- [Banco Central do Brasil](https://www.bcb.gov.br/) - Economic indicators
- All contributors and supporters of this project

## 📧 Contact

Ana Lucatti - [@analucatti](https://github.com/analucatti)

Project Link: [https://github.com/analucatti/brazil_finance_indicators](https://github.com/analucatti/brazil_finance_indicators)

## 🚧 Roadmap

- [ ] Advanced charting capabilities with technical indicators
- [ ] Real Estate Funds (FIIs) tracking
- [ ] Options chain viewer
- [ ] Social features (watchlists sharing)
- [ ] AI-powered market insights
- [ ] Desktop application support
- [ ] Integration with Brazilian brokers
- [ ] Tax calculation tools for Brazilian investors

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.

## ⚠️ Disclaimer

This application is for informational purposes only. It should not be considered as financial advice. Always do your own research and consult with qualified financial advisors before making investment decisions.

---

<p align="center">Made with ❤️ in Brazil 🇧🇷<
