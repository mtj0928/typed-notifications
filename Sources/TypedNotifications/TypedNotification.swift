import Foundation

/// A type-safe notification.
public struct TypedNotification<Storage, Object> {
    /// A name of the received notification
    public let name: Notification.Name
    
    /// A type-safe storage for values or objects related to this notification.
    ///
    /// This value is converted from `userInfo` of the notification.
    public let storage: Storage

    /// A type-safe object that the poster wishes to send to observers.
    public let object: Object?

    public init(
        name: Notification.Name,
        storage: Storage,
        object: Object? = nil
    ) {
        self.name = name
        self.storage = storage
        self.object = object
    }
}

extension TypedNotification {
    init?(_ notification: Notification, basedOn definition: TypedNotificationDefinition<Storage, Object>) {
        if Storage.self == Void.self,
           notification.userInfo?.isEmpty == false {
            assertionFailure("An expected type is Void, but userInfo contains values.")
        }

        do {
            let storage = try definition.decode(notification.userInfo)
            let object = notification.object as? Object
            self.init(name: notification.name, storage: storage, object: object)
        } catch {
            assertionFailure("Unexpected error occur: \(error.localizedDescription)")
            return nil
        }
    }
}
