#if canImport(UIKit) && !os(visionOS)
import UserInfoRepresentable
import UIKit

extension UIResponder {
    public static var keyboardWillShowTypedNotification: TypedNotificationDefinition<KeyboardNotificationStorage, UIScreen> {
        .init(name: UIResponder.keyboardWillShowNotification)
    }

    public static var keyboardDidShowTypedNotification: TypedNotificationDefinition<KeyboardNotificationStorage, UIScreen> {
        .init(name: UIResponder.keyboardDidShowNotification)
    }

    public static var keyboardWillHideTypedNotification: TypedNotificationDefinition<KeyboardNotificationStorage, UIScreen> {
        .init(name: UIResponder.keyboardWillHideNotification)
    }

    public static var keyboardDidHideTypedNotification: TypedNotificationDefinition<KeyboardNotificationStorage, UIScreen> {
        .init(name: UIResponder.keyboardDidHideNotification)
    }

    public static var keyboardWillChangeFrameTypedNotification: TypedNotificationDefinition<KeyboardNotificationStorage, UIScreen> {
        .init(name: UIResponder.keyboardWillChangeFrameNotification)
    }

    public static var keyboardDidChangeFrameTypedNotification: TypedNotificationDefinition<KeyboardNotificationStorage, UIScreen> {
        .init(name: UIResponder.keyboardDidChangeFrameNotification)
    }
}

public struct KeyboardNotificationStorage: UserInfoRepresentable {
    /// A `Bool` value that indicates whether the keyboard belongs to the current app.
    public let isLocal: Bool?

    /// The keyboard’s frame at the beginning of its animation.
    public let frameBegin: CGRect?

    /// The keyboard’s frame at the end of its animation.
    public let frameEnd: CGRect?

    /// The animation curve that the system uses to animate the keyboard onto or off the screen.
    public let animationOptions: UIView.AnimationOptions?

    ///  The duration of the keyboard animation in seconds.
    public let animationDuration: TimeInterval?

    public init(
        isLocal: Bool?,
        frameBegin: CGRect?,
        frameEnd: CGRect?,
        animationOptions: UIView.AnimationOptions?,
        animationDuration: Double?
    ) {
        self.isLocal = isLocal
        self.frameBegin = frameBegin
        self.frameEnd = frameEnd
        self.animationOptions = animationOptions
        self.animationDuration = animationDuration
    }

    public init(userInfo: [AnyHashable: Any]) {
        self.isLocal = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? Bool
        self.frameBegin = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
        self.frameEnd = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect

        let rawAnimationOptions = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        self.animationOptions = rawAnimationOptions.map { UIView.AnimationOptions(rawValue: $0 << 16) }
        self.animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
    }

    public func convertToUserInfo() -> [AnyHashable : Any] {
        let candidate: [AnyHashable: Any?] = [
            UIResponder.keyboardIsLocalUserInfoKey: isLocal,
            UIResponder.keyboardFrameBeginUserInfoKey: frameBegin,
            UIResponder.keyboardFrameEndUserInfoKey: frameEnd,
            UIResponder.keyboardAnimationCurveUserInfoKey: animationOptions.map { $0.rawValue >> 16 },
            UIResponder.keyboardAnimationDurationUserInfoKey: animationDuration
        ]
        return candidate.compactMapValues { $0 }
    }
}
#endif
