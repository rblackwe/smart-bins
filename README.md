# Smart Bins Management System

[![Live Demo](https://img.shields.io/badge/demo-live-brightgreen)](https://smart-bins-divine-field-5379.fly.dev/)
[![Elixir](https://img.shields.io/badge/elixir-%23663399.svg?style=flat&logo=elixir&logoColor=white)](https://elixir-lang.org/)
[![Phoenix](https://img.shields.io/badge/phoenix-%23FD4F00.svg?style=flat&logo=phoenixframework&logoColor=white)](https://phoenixframework.org/)
[![Deployed on Fly.io](https://img.shields.io/badge/deployed%20on-Fly.io-blueviolet)](https://fly.io/)

A modern warehouse inventory management system with AI-powered bin identification and real-time tracking capabilities.

## 🚀 Live Demo

**Visit the live app:** [https://smart-bins-divine-field-5379.fly.dev/](https://smart-bins-divine-field-5379.fly.dev/)

## ✨ Features

### 🔥 Core Functionality
- **Real-time inventory tracking** across multiple containers
- **AI-powered bin scanning** with realistic content identification
- **Advanced filtering system** (search, status, container)
- **Warehouse-style interface** with industrial dark theme
- **Container.bin ID system** for precise location tracking
- **Status management** (Full, Partial, Empty) with color coding

### 🎯 Key Capabilities
- **Search functionality** - Find bins by description or content
- **Container filtering** - View bins by specific storage containers
- **Status filtering** - Filter by Full, Partial, or Empty bins
- **AI scanning simulation** - Mock AI generates realistic descriptions
- **Real-time updates** - LiveView with PubSub for instant synchronization
- **Responsive design** - Works seamlessly on desktop and mobile

### 📊 Demo Data
The system includes realistic demo data across 5 containers:

- **Container 1**: Electronics (Arduino boards, resistors, LED strips, breadboards)
- **Container 2**: Hardware (M3 screws, hex nuts, washers, allen keys)
- **Container 3**: Tools (Digital calipers, tweezers, heat shrink tubing)
- **Container 4**: Motors (NEMA 17 steppers, servo motors, timing belts)
- **Container 5**: Power & Displays (Power supplies, OLED displays, capacitors)

## 🏗️ Technical Architecture

### Technology Stack
- **Backend**: Elixir/Phoenix Framework
- **Frontend**: Phoenix LiveView with Tailwind CSS
- **Database**: SQLite with persistent storage
- **File System**: Local filesystem for image storage
- **AI**: Mock AI module for realistic content identification
- **Deployment**: Fly.io with automatic scaling

### Key Components
- **Phoenix LiveView Streams** - Efficient real-time collection management
- **PubSub Integration** - Real-time updates across sessions
- **Mock AI Module** - Generates varied, realistic bin descriptions
- **Local File System** - Images served from `priv/static/bin_images/`
- **Release Tasks** - Production database seeding

## 🚀 Getting Started

### Prerequisites
- Elixir 1.15+
- Phoenix 1.7+
- Node.js (for asset compilation)

### Local Development

1. **Clone the repository:**
   ```bash
   git clone https://github.com/rblackwe/smart-bins.git
   cd smart-bins
   ```

2. **Install dependencies:**
   ```bash
   mix deps.get
   ```

3. **Set up the database:**
   ```bash
   mix ecto.setup
   ```

4. **Seed demo data:**
   ```bash
   mix run priv/repo/seeds.exs
   ```

5. **Start the development server:**
   ```bash
   mix phx.server
   ```

6. **Visit the app:**
   Open [http://localhost:4000](http://localhost:4000) in your browser

### Production Deployment

The app is configured for deployment on Fly.io:

1. **Install Fly CLI:**
   ```bash
   curl -L https://fly.io/install.sh | sh
   ```

2. **Deploy:**
   ```bash
   fly deploy
   ```

3. **Seed production data:**
   ```bash
   fly ssh console -C "/app/bin/smart_bins eval 'SmartBins.Release.seed()'"
   ```

## 📁 Project Structure

```
smart-bins/
├── lib/
│   ├── smart_bins/
│   │   ├── ai.ex                    # Mock AI content identification
│   │   ├── file_system.ex           # Local filesystem image handling
│   │   ├── inventory/               # Core inventory logic
│   │   └── release.ex               # Production deployment tasks
│   └── smart_bins_web/
│       ├── live/
│       │   └── bins_live.ex         # Main LiveView interface
│       └── components/              # Reusable UI components
├── priv/
│   ├── repo/seeds.exs              # Demo data seeding
│   └── static/bin_images/          # Placeholder images
├── assets/                         # Frontend assets
└── config/                         # Application configuration
```

## 🎮 Usage

### Basic Operations

1. **Browse Bins**: View all bins in a data-dense warehouse-style interface
2. **Search**: Use the search bar to find specific items or descriptions
3. **Filter by Container**: Select specific containers (1-5) to narrow results
4. **Filter by Status**: Show only Full, Partial, or Empty bins
5. **Scan Bins**: Click "SCAN" buttons to simulate AI identification
6. **View Details**: Click any bin row to see detailed information

### AI Scanning Simulation

The mock AI module generates realistic descriptions like:
- "AI detected: Arduino Uno microcontrollers (qty: ~12, condition: new) - 94% confidence"
- "AI detected: M3 x 8mm socket head screws (qty: ~45, condition: new) - 92% confidence"
- "AI detected: Digital calipers (150mm) (qty: ~3, condition: excellent) - 95% confidence"

## 🛠️ Development

### Adding New Features

The codebase is structured for easy extension:

- **New AI capabilities**: Extend `SmartBins.AI` module
- **Additional filters**: Update the LiveView filter logic
- **New bin types**: Add to seeding data and expand schemas
- **UI enhancements**: Modify Tailwind classes and LiveView templates

### Testing

Run the test suite:
```bash
mix test
```

### Code Quality

The project follows Elixir best practices:
- **Contexts** for business logic organization
- **LiveView streams** for efficient collection handling
- **PubSub** for real-time features
- **Structured seeding** for consistent demo data

## 📈 Performance Features

- **LiveView Streams**: Efficient handling of large bin collections
- **Real-time Updates**: PubSub integration for instant synchronization
- **Responsive Design**: Optimized for various screen sizes
- **Minimal Dependencies**: No external API requirements for demo
- **Local Storage**: Fast image serving from local filesystem

## 🔧 Configuration

### Environment Variables
- `DATABASE_URL`: Database connection string (production)
- `SECRET_KEY_BASE`: Phoenix secret key (production)
- `PHX_HOST`: Hostname for production URLs

### Development Settings
All development configurations are pre-configured for immediate use.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🎯 Future Enhancements

- **Real AI Integration**: Connect to actual computer vision APIs
- **Barcode Scanning**: QR/barcode support for bin identification
- **User Authentication**: Multi-user support with role-based access
- **Export Features**: CSV/PDF reporting capabilities
- **Mobile App**: Native mobile companion app
- **Advanced Analytics**: Usage patterns and inventory insights

---

**Built with ❤️ using Elixir and Phoenix LiveView**

For questions or support, please open an issue on GitHub.
