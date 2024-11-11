# game_news

A new Flutter project.


## Flutter Version
- 3.24.3 (stable)

## Framework & Libraries
- Bloc state management
- Dio for API
- go_router for route config
<!-- - easy_localization for multiple languages 還沒用 -->

## Directory Structure

```tree
lib/
  ├── main.dart
  ├── app.dart
  ├── config/
  │   └── router.dart      # GoRouter 配置
  ├── core/
  │   ├── dio_client.dart  # Dio HTTP 客戶端配置
  │   └── constants.dart    
  ├── features/
  │   └── feature_name/
  │       ├── data/
  │       │   ├── models/
  │       │   └── repositories/
  │       ├── domain/
  │       │   └── entities/
  │       └── presentation/
  │           ├── bloc/
  │           ├── pages/
  │           └── widgets/
  └── shared/
      ├── widgets/
      └── utils/
```
## Generate Files Command
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs