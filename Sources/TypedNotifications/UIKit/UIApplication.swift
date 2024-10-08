#if canImport(UIKit)
import UIKit

extension UIApplication {
    @Notification(name: UIApplication.didBecomeActiveNotification)
    public static var didBecomeActiveTypedNotification: TypedNotificationDefinition<Void, UIApplication>

    @Notification(name: UIApplication.didEnterBackgroundNotification)
    public static var didEnterBackgroundTypedNotification: TypedNotificationDefinition<Void, UIApplication>

    @Notification(name: UIApplication.willEnterForegroundNotification)
    public static var willEnterForegroundTypedNotification: TypedNotificationDefinition<Void, UIApplication>

    @Notification(name: UIApplication.willResignActiveNotification)
    public static var willResignActiveTypedNotification: TypedNotificationDefinition<Void, UIApplication>

    @Notification(name: UIApplication.willTerminateNotification)
    public static var willTerminateTypedNotification: TypedNotificationDefinition<Void, UIApplication>
}
#endif
