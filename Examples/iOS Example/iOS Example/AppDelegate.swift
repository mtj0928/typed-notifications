import UIKit
import Combine
import TypedNotifications

final class AppDelegate: NSObject, UIApplicationDelegate {

    private var cancellable: [AnyCancellable] = []

    override init() {
        super.init()

        // MARK: - UIApplication
        [
            UIApplication.didBecomeActiveTypedNotification,
            UIApplication.didEnterBackgroundTypedNotification,
            UIApplication.willEnterForegroundTypedNotification,
            UIApplication.willResignActiveTypedNotification,
            UIApplication.willTerminateTypedNotification
        ].forEach { definition in
            TypedNotificationCenter.default.publisher(for: definition)
                .sink { printNotification($0) }
                .store(in: &cancellable)
        }
        
        // MARK: - UIScene
        [
            UIScene.willConnectTypedNotification,
            UIScene.didActivateTypedNotification,
            UIScene.didDisconnectTypedNotification,
            UIScene.willEnterForegroundTypedNotification,
            UIScene.willDeactivateTypedNotification,
            UIScene.didEnterBackgroundTypedNotification
        ].forEach { definition in
            TypedNotificationCenter.default.publisher(for: definition)
                .sink { printNotification($0) }
                .store(in: &cancellable)
        }

        // MARK: - UIResponder
        [
            UIResponder.keyboardWillShowTypedNotification,
            UIResponder.keyboardDidShowTypedNotification,
            UIResponder.keyboardWillHideTypedNotification,
            UIResponder.keyboardDidHideTypedNotification,
            UIResponder.keyboardWillChangeFrameTypedNotification,
            UIResponder.keyboardDidChangeFrameTypedNotification
        ].forEach { definition in
            TypedNotificationCenter.default.publisher(for: definition)
                .sink { notification in printNotification(notification) }
                .store(in: &cancellable)
        }
    }
}
