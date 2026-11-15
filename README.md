# valorant-tracker-ios

App iOS cá nhân theo dõi chỉ số Valorant. Swift, UIKit viết bằng code (không storyboard), MVVM + Coordinator, iOS 16+.
Gọi backend `valorant-tracker-backend` ở `http://localhost:8080`.

## Chạy

File `.xcodeproj` được sinh từ `project.yml` bằng XcodeGen nên không nằm trong repo.

```bash
brew install xcodegen
xcodegen generate
open ValorantTracker.xcodeproj
```

Chạy backend trước, rồi Run trên Simulator. Nếu chạy trên máy thật, đổi `AppConfig.baseURL` sang IP máy Mac trong mạng LAN.

## Cấu trúc

Chia theo tính năng, mỗi tính năng có đủ các tầng MVVM + Clean Architecture.
Trong một tính năng, phụ thuộc chỉ đi một chiều: Presentation → Domain ← Data.

```
ValorantTracker
├── App/        AppDelegate, SceneDelegate, AppCoordinator, AppDIContainer, AppConfig
├── Core/       Dùng chung giữa các tính năng
│   ├── Domain/     RiotID
│   ├── Network/    APIClient, APIError
│   └── UI/         Theme
└── Features/
    ├── Player/
    │   ├── Domain/         Entities/PlayerProfile, Repositories/PlayerRepository, UseCases/GetPlayerProfileUseCase
    │   ├── Data/           DTOs/PlayerProfileDTO, Repositories/APIPlayerRepository
    │   └── Presentation/   Search/ và Profile/ (mỗi màn một ViewController + ViewModel)
    └── Matches/
        ├── Domain/         Entities/MatchSummary, Repositories/MatchRepository, UseCases/GetRecentMatchesUseCase
        ├── Data/           DTOs/MatchSummaryDTO, Repositories/APIMatchRepository
        └── Presentation/   MatchesViewController, MatchesViewModel, MatchCell
ValorantTrackerTests  test parse Riot ID và decode DTO
```

Thêm tính năng mới (ví dụ `Stats`): tạo thư mục trong `Features/` với đủ Domain, Data, Presentation, rồi nối trong `AppDIContainer` và `AppCoordinator`. Các tính năng không gọi thẳng vào nhau; thứ dùng chung đặt trong `Core/`.

## Việc cần làm tiếp

1. Thêm Kingfisher (Swift Package) để tải ảnh agent, rank, map.
2. Màn Hồ sơ: rank, RR, các ô chỉ số, biểu đồ, khi backend có endpoint `/stats`.
3. Chuyển điều hướng sang tab bar như bản thiết kế.
4. Lưu các Riot ID tìm gần đây bằng `UserDefaults`.
