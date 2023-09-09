import TypedNotifications

func printNotification<Storage, Object>(_ notification: TypedNotification<Storage, Object>) {
    let text = """
    Received Notification:
    ├─ name = \(notification.name.rawValue),
    ├─ storage = \(notification.storage),
    └─ object = \(notification.object.debugDescription)
    """
    print(text)
}
