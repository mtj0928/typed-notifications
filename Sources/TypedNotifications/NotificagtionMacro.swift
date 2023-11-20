#if canImport(TypedNotificationsMacro)
import TypedNotificationsMacro

@attached(accessor)
public macro Notification() = #externalMacro(module: "TypedNotificationsMacro", type: "NotificationMacro")

@attached(accessor)
public macro Notification(name: String) = #externalMacro(module: "TypedNotificationsMacro", type: "NotificationMacro")
#endif
