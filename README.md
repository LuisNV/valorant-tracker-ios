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

```
ValorantTracker
├── App/        AppDelegate, SceneDelegate, AppCoordinator (điều hướng)
├── Core/       APIClient, APIError, AppConfig, Theme
├── Models/     RiotID, PlayerProfile, MatchSummary (khớp DTO của backend)
├── Services/   PlayerService (protocol + bản gọi API)
└── Features/
    ├── Search/   nhập Riot ID
    ├── Profile/  hồ sơ người chơi
    └── Matches/  danh sách trận (UITableView + diffable data source)
ValorantTrackerTests  test parse Riot ID và decode JSON
```

## Việc cần làm tiếp

1. Thêm Kingfisher (Swift Package) để tải ảnh agent, rank, map.
2. Màn Hồ sơ: rank, RR, các ô chỉ số, biểu đồ, khi backend có endpoint `/stats`.
3. Chuyển điều hướng sang tab bar như bản thiết kế.
4. Lưu các Riot ID tìm gần đây bằng `UserDefaults`.
