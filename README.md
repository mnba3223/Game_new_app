# game_news

A new Flutter project.


## Flutter Version
- 3.24.3 (stable)

## Framework & Libraries
- Bloc state management
- Dio for API
- go_router for route config
<!-- - easy_localization for multiple languages -->

## Directory Structure

```tree
/
└─ lib/                        
   ├─ data/                    # Data layer
   │  ├─ models/              # Data models
   │  ├─ network/            # Network related
   │  │  ├─ config/         # API configurations
   │  │  ├─ core/          # Core functionalities
   │  │  ├─ interceptors/  # Network interceptors
   │  │  └─ apis/         # API definitions
   │  └─ repositories/    # Data access layer
   ├─ presentation/      # Presentation layer
   │  ├─ screens/       # Full pages
   │  └─ ui_widget/     # UI components
   ├─ state_management/ # State management
   │  ├─ blocs/        # BLoC components
   │  └─ cubit/        # Cubit components
   ├─ config/          # Configuration
   ├─ theme/           # Theme settings
   └─ utils/           # Utilities
```
## Generate Files Command
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs