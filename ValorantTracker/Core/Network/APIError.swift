import Foundation

enum APIError: LocalizedError {
    case notFound
    case rateLimited
    case server(statusCode: Int)
    case decoding(Error)
    case transport(Error)

    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Không tìm thấy người chơi. Kiểm tra lại Riot ID."
        case .rateLimited:
            return "Đang gọi quá nhiều lần. Thử lại sau một phút."
        case .server(let statusCode):
            return "Máy chủ trả về lỗi \(statusCode)."
        case .decoding:
            return "Dữ liệu trả về không đúng định dạng."
        case .transport:
            return "Không kết nối được tới máy chủ. Kiểm tra backend đã chạy chưa."
        }
    }
}
