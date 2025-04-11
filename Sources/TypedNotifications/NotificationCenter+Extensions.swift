import Foundation

extension NotificationCenter {
    public func post<Storage, Object>(
        _ definition: TypedNotificationDefinition<Storage, Object>,
        storage: Storage,
        object: Object? = nil
    ) {
        let userInfo = definition.encode(storage)
        let notification = Notification(name: definition.name, object: object, userInfo: userInfo)
        post(notification)
    }

    public func post<Object>(
        _ definition: TypedNotificationDefinition<Void, Object>,
        object: Object? = nil
    ) {
        let notification = Notification(name: definition.name, object: object, userInfo: nil)
        post(notification)
    }
}

extension NotificationCenter {

    @available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
    public typealias AsyncNotifications<Element> = AsyncCompactMapSequence<NotificationCenter.Notifications, Element>

    @available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
    public func notifications<Storage, Object: AnyObject & Sendable>(
        for definition: TypedNotificationDefinition<Storage, Object>,
        object: Object? = nil
    ) -> AsyncNotifications<TypedNotification<Storage, Object>> {
        notifications(named: definition.name, object: object)
            .compactMap { TypedNotification($0, basedOn: definition) }
    }
}
