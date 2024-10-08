#if canImport(UIKit)
import UIKit

extension UIScene {
    @Notification(name: UIScene.willConnectNotification)
    public static var willConnectTypedNotification: TypedNotificationDefinition<Void, UIScene>

    @Notification(name: UIScene.didActivateNotification)
    public static var didActivateTypedNotification: TypedNotificationDefinition<Void, UIScene>

    @Notification(name: UIScene.didDisconnectNotification)
    public static var didDisconnectTypedNotification: TypedNotificationDefinition<Void, UIScene>

    @Notification(name: UIScene.willEnterForegroundNotification)
    public static var willEnterForegroundTypedNotification: TypedNotificationDefinition<Void, UIScene>

    @Notification(name: UIScene.willDeactivateNotification)
    public static var willDeactivateTypedNotification: TypedNotificationDefinition<Void, UIScene>

    @Notification(name: UIScene.didEnterBackgroundNotification)
    public static var didEnterBackgroundTypedNotification: TypedNotificationDefinition<Void, UIScene> 
}
#endif
