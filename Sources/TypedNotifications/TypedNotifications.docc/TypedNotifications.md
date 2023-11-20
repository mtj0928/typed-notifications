# ``TypedNotifications``

A library attaching type-information to `NotificationCenter`

## Overview

This library attaches type-information to `NotificationCenter`.
You can post and observe notifications in a type-safe manner.

Define a notification and how to encode/decode the userInfo in `TypedNotificationDefinition`.
```swift
extension TypedNotificationDefinition {
    static var userNameWillUpdate: TypedNotificationDefinition<String, User> {
        .init(name: "userWillUpdate") { newName in
            ["newName": newName]
        } decode: { userInfo in
            userInfo?["newName"] as? String ?? ""
        }
    }
}
```

And then, you can post/observe the notifications in type safe manner.
```swift
// [Post]
// Notifications can be posted in a type safe manner.
let newName: String = ...
let user: User = ...
TypedNotificationCenter.default.post(.userNameWillUpdate, storage: newName, object: user)

// [Observation]
TypedNotificationCenter.default
    .publisher(for: .userNameWillUpdate, object: user)
    .sink { notification in
        // Notifications can be received in a type safe manner.
        let newName = notification.storage
        let user: User? = notification.object
        // ...
    }
```

## UserInfoRepresentable

``UserInfoRepresentable`` is a protocol for encoding and decoding your type and `userInfo`.

```swift
struct UserNameUpdateNotificationStorage: UserInfoRepresentable {
    let oldName: String
    let newName: String

    init(userInfo: [AnyHashable: Any]) {
        self.oldName = (userInfo["oldName"] as? String) ?? ""
        self.newName = (userInfo["newName"] as? String) ?? ""
    }

    func convertToUserInfo() -> [AnyHashable : Any] {
        [
            "oldName": oldName,
            "newName": newName
        ]
    }
}
```

And then you can use `@Ntification` macro.
```swift
extension TypedNotificationDefinition {
    @Notification
    static var userNameUpdate: TypedNotificationDefinition<UserNameUpdateNotificationStorage, User> 
}
```
