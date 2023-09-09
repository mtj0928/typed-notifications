import UIKit
import Combine
import TypedNotifications

final class AppDelegate: NSObject, UIApplicationDelegate {

    private var cancellable: [AnyCancellable] = []

    override init() {
        super.init()

        [
            UIApplication.didBecomeActiveTypedNotification,
            UIApplication.didEnterBackgroundTypedNotification,
            UIApplication.willEnterForegroundTypedNotification,
            UIApplication.willResignActiveTypedNotification,
            UIApplication.willTerminateTypedNotification
        ].forEach { definition in
            TypedNotificationCenter.default.publisher(for: definition)
                .sink {
                    printNotification($0)
                    print("")
                }
                .store(in: &cancellable)
        }

        [
            UIScene.willConnectTypedNotification,
            UIScene.didActivateTypedNotification,
            UIScene.didDisconnectTypedNotification,
            UIScene.willEnterForegroundTypedNotification,
            UIScene.willDeactivateTypedNotification,
            UIScene.didEnterBackgroundTypedNotification
        ].forEach { definition in
            TypedNotificationCenter.default.publisher(for: definition)
                .sink {
                    printNotification($0)
                    print("")
                }
                .store(in: &cancellable)
        }
    }
}
