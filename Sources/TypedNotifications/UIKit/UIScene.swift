#if canImport(UIKit)
import UIKit

extension UIScene {
    public static var willConnectTypedNotification: TypedNotificationDefinition<Void, UIScene> {
        .init(name: UIScene.willConnectNotification)
    }

    public static var didActivateTypedNotification: TypedNotificationDefinition<Void, UIScene> {
        .init(name: UIScene.didActivateNotification)
    }

    public static var didDisconnectTypedNotification: TypedNotificationDefinition<Void, UIScene> {
        .init(name: UIScene.didDisconnectNotification)
    }

    public static var willEnterForegroundTypedNotification: TypedNotificationDefinition<Void, UIScene> {
        .init(name: UIScene.willEnterForegroundNotification)
    }

    public static var willDeactivateTypedNotification: TypedNotificationDefinition<Void, UIScene> {
        .init(name: UIScene.willDeactivateNotification)
    }

    public static var didEnterBackgroundTypedNotification: TypedNotificationDefinition<Void, UIScene> {
        .init(name: UIScene.didEnterBackgroundNotification)
    }
}
#endif
