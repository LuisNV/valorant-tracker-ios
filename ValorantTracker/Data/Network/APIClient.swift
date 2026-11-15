import Foundation

final class APIClient {

    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder

    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = APIClient.makeDecoder()
    }

    /// GET a JSON resource. Each path component is percent-encoded separately,
    /// so player names with spaces or special characters are safe.
    func get<T: Decodable>(_ pathComponents: [String], query: [URLQueryItem] = []) async throws -> T {
        var url = baseURL
        for component in pathComponents {
            url.append(path: component)
        }
        if !query.isEmpty {
            url.append(queryItems: query)
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw APIError.transport(error)
        }

        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        switch statusCode {
        case 200..<300:
            break
        case 404:
            throw APIError.notFound
        case 429:
            throw APIError.rateLimited
        default:
            throw APIError.server(statusCode: statusCode)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }

    /// The backend sends java.time.Instant as ISO-8601, with or without fractional seconds.
    static func makeDecoder() -> JSONDecoder {
        let withFraction = ISO8601DateFormatter()
        withFraction.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let plain = ISO8601DateFormatter()
        plain.formatOptions = [.withInternetDateTime]

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            if let date = withFraction.date(from: string) ?? plain.date(from: string) {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
        }
        return decoder
    }
}
