import Foundation

public struct TypedNotificationDefinition<Storage, Object>: Sendable {
    public let name: Notification.Name
    public let encode: @Sendable (Storage) -> [AnyHashable: Any]
    public let decode: @Sendable ([AnyHashable: Any]?) -> Storage

    public init(
        name: Notification.Name,
        encode: @Sendable @escaping (Storage) -> [AnyHashable: Any],
        decode: @Sendable @escaping ([AnyHashable : Any]?) -> Storage
    ) {
        self.name = name
        self.encode = encode
        self.decode = decode
    }

    public init(
        name: String,
        encode: @Sendable @escaping (Storage) -> [AnyHashable: Any],
        decode: @Sendable @escaping ([AnyHashable : Any]?) -> Storage
    ) {
        self.name = Notification.Name(name)
        self.encode = encode
        self.decode = decode
    }

    public init(name: Notification.Name) where Storage == Void {
        self.name = name
        self.encode = { _ in [:] }
        self.decode = { _ in }
    }

    public init(name: String) where Storage == Void {
        self.name = Notification.Name(name)
        self.encode = { _ in [:] }
        self.decode = { _ in }
    }
}
