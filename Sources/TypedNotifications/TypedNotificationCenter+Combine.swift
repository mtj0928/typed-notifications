#if canImport(Combine)
import Combine
import Foundation

extension TypedNotificationCenter {

    public func publisher<Storage, Object: AnyObject>(
        for definition: TypedNotificationDefinition<Storage, Object>,
        object: Object? = nil
    ) -> some Publisher<TypedNotification<Storage, Object>, Never> {
        notificationCenter.publisher(for: definition.name, object: object)
            .map { TypedNotification($0, basedOn: definition) }
    }
}
#endif
