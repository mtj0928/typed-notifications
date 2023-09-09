#if canImport(Combine)
import Combine
import Foundation

extension TypedNotificationCenter {

    public func publisher<Storage, Object: AnyObject>(
        for definition: TypedNotificationDefinition<Storage, Object>,
        object: Object? = nil
    ) -> some Publisher<TypedNotification<Storage, Object>, Never> {
        notificationCenter.publisher(for: definition.name, object: object)
            .map { notification in
                let storage = definition.decode(notification.userInfo)
                let object = notification.object as? Object
                return TypedNotification(name: notification.name, storage: storage, object: object)
            }
    }
}
#endif
