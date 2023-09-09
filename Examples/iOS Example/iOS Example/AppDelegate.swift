import UIKit
import Combine
import TypedNotifications

final class AppDelegate: NSObject, UIApplicationDelegate {

    private var cancellable: [AnyCancellable] = []

    override init() {
        super.init()

        [
            TypedNotificationDefinition<Void, UIApplication>.didBecomeActiveNotification,
            .didEnterBackgroundNotification,
            .willEnterForegroundNotification,
            .willResignActiveNotification,
            .willTerminateNotification
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

func printNotification<Storage, Object>(_ notification: TypedNotification<Storage, Object>) {
    let text = """
    Notification received:
    ├─ name = \(notification.name.rawValue),
    ├─ storage = \(notification.storage),
    └─ object = \(notification.object.debugDescription)
    """
    print(text)
}
