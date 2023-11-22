import TypedNotificationsMacro

/// A macro for defining a notification whose notification name is attached property name.
@attached(accessor)
public macro Notification() = #externalMacro(module: "TypedNotificationsMacro", type: "NotificationMacro")

/// A macro for defining a notification.
///
/// - Parameter name: A name of the notification.
@attached(accessor)
public macro Notification(name: String) = #externalMacro(module: "TypedNotificationsMacro", type: "NotificationMacro")
