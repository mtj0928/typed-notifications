import Foundation
import Combine

/// A wrapper of `NotificationCenter` attaching a type information to a `Notification`.
public struct TypedNotificationCenter: Sendable {
    let notificationCenter: NotificationCenter

    public init(notificationCenter: NotificationCenter = NotificationCenter()) {
        self.notificationCenter = notificationCenter
    }

    public func post<Storage, Object>(
        _ definition: TypedNotificationDefinition<Storage, Object>,
        storage: Storage,
        object: Object? = nil
    ) {
        let userInfo = definition.encode(storage)
        let notification = Notification(name: definition.name, object: object, userInfo: userInfo)
        notificationCenter.post(notification)
    }

    public func post<Object>(
        _ definition: TypedNotificationDefinition<Void, Object>,
        object: Object? = nil
    ) {
        let notification = Notification(name: definition.name, object: object, userInfo: nil)
        notificationCenter.post(notification)
    }
}

extension TypedNotificationCenter {

    @available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
    public typealias Notifications<Element> = AsyncMapSequence<NotificationCenter.Notifications, Element>

    @available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
    public func notifications<Storage, Object: AnyObject>(
        for definition: TypedNotificationDefinition<Storage, Object>,
        object: Object? = nil
    ) -> Notifications<TypedNotification<Storage, Object>> {
        notificationCenter.notifications(named: definition.name, object: object)
            .map { TypedNotification($0, basedOn: definition) }
    }
}

extension TypedNotificationCenter {
    public static let `default` = TypedNotificationCenter(notificationCenter: .default)
}
