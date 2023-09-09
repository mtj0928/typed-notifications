#if canImport(UIKit)
import UIKit

extension UIApplication {

    public static var didBecomeActiveTypedNotification: TypedNotificationDefinition<Void, UIApplication> {
        .init(name: UIApplication.didBecomeActiveNotification)
    }

    public static var didEnterBackgroundTypedNotification: TypedNotificationDefinition<Void, UIApplication> {
        .init(name: UIApplication.didEnterBackgroundNotification)
    }

    public static var willEnterForegroundTypedNotification: TypedNotificationDefinition<Void, UIApplication> {
        .init(name: UIApplication.willEnterForegroundNotification)
    }

    public static var willResignActiveTypedNotification: TypedNotificationDefinition<Void, UIApplication> {
        .init(name: UIApplication.willResignActiveNotification)
    }

    public static var willTerminateTypedNotification: TypedNotificationDefinition<Void, UIApplication> {
        .init(name: UIApplication.willTerminateNotification)
    }
}
#endif
