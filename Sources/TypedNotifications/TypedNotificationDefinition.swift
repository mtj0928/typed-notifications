import Foundation

public struct TypedNotificationDefinition<Storage, Object> {
    public let name: Notification.Name
    public let encode: (Storage) -> [AnyHashable: Any]
    public let decode: ([AnyHashable: Any]?) -> Storage

    public init(
        name: Notification.Name,
        encode: @escaping (Storage) -> [AnyHashable: Any],
        decode: @escaping ([AnyHashable : Any]?) -> Storage
    ) {
        self.name = name
        self.encode = encode
        self.decode = decode
    }

    public init(
        name: String,
        encode: @escaping (Storage) -> [AnyHashable: Any],
        decode: @escaping ([AnyHashable : Any]?) -> Storage
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
