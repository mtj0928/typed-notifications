#if canImport(UIKit)
import UIKit

// MARK: - UIApplication

@MainActor
extension TypedNotificationDefinition {

    public static var didBecomeActiveNotification: TypedNotificationDefinition<Void, UIApplication> {
        .init(name: UIApplication.didBecomeActiveNotification)
    }

    public static var didEnterBackgroundNotification: TypedNotificationDefinition<Void, UIApplication> {
        .init(name: UIApplication.didEnterBackgroundNotification)
    }

    public static var willEnterForegroundNotification: TypedNotificationDefinition<Void, UIApplication> {
        .init(name: UIApplication.willEnterForegroundNotification)
    }

    public static var willResignActiveNotification: TypedNotificationDefinition<Void, UIApplication> {
        .init(name: UIApplication.willResignActiveNotification)
    }

    public static var willTerminateNotification: TypedNotificationDefinition<Void, UIApplication> {
        .init(name: UIApplication.willTerminateNotification)
    }
}
#endif
