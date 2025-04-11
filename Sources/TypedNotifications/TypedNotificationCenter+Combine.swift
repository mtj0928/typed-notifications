#if canImport(Combine)
import Combine
import Foundation

extension TypedNotificationCenter {
    public func publisher<Storage, Object: AnyObject>(
        for definition: TypedNotificationDefinition<Storage, Object>,
        object: Object? = nil
    ) -> some Publisher<TypedNotification<Storage, Object>, Never> {
        notificationCenter.publisher(for: definition.name, object: object)
            .compactMap { TypedNotification($0, basedOn: definition) }
    }
}

extension NotificationCenter {
    public func publisher<Storage, Object: AnyObject>(
        for definition: TypedNotificationDefinition<Storage, Object>,
        object: Object? = nil
    ) -> AnyPublisher<TypedNotification<Storage, Object>, Never> {
        publisher(for: definition.name, object: object)
            .compactMap { TypedNotification($0, basedOn: definition) }
            .eraseToAnyPublisher()
    }
}
#endif
