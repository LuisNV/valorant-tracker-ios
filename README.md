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

MVVM + Clean Architecture. Phụ thuộc chỉ đi một chiều: Presentation → Domain ← Data.

```
ValorantTracker
├── App/            AppDelegate, SceneDelegate, AppCoordinator, AppDIContainer, AppConfig
├── Domain/         Swift thuần, không import UIKit hay gọi mạng
│   ├── Entities/       RiotID, PlayerProfile, MatchSummary
│   ├── Repositories/   PlayerRepository (protocol)
│   └── UseCases/       GetPlayerProfileUseCase, GetRecentMatchesUseCase
├── Data/           Hiện thực các protocol của Domain
│   ├── Network/        APIClient, APIError
│   ├── DTOs/           PlayerProfileDTO, MatchSummaryDTO (+ toDomain)
│   └── Repositories/   APIPlayerRepository
└── Presentation/   MVVM: mỗi màn một ViewController + ViewModel
    ├── Common/         Theme
    ├── Search/
    ├── Profile/
    └── Matches/
ValorantTrackerTests  test parse Riot ID và decode DTO
```

Thêm tính năng mới theo thứ tự: entity và protocol repository trong Domain, use case, DTO và repository trong Data, rồi ViewModel và ViewController, cuối cùng nối trong `AppDIContainer`.

## Việc cần làm tiếp

1. Thêm Kingfisher (Swift Package) để tải ảnh agent, rank, map.
2. Màn Hồ sơ: rank, RR, các ô chỉ số, biểu đồ, khi backend có endpoint `/stats`.
3. Chuyển điều hướng sang tab bar như bản thiết kế.
4. Lưu các Riot ID tìm gần đây bằng `UserDefaults`.
