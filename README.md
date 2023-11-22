# typed-notifications
This library is attaching type-information to `NotificationCenter`.
You can post and observe notifications in a type-safe manner.

```swift
TypedNotificationCenter.default
    .publisher(for: .userNameWillUpdate, object: user)
    .sink { notification in
        // Notifications can be received in a type safe manner.
        let storage: UserNameUpdateNotificationStorage = notification.storage
        let user: User? = notification.object
        // ...
    }

extension TypedNotificationDefinition {
    @Notification
    static var userNameUpdate: TypedNotificationDefinition<UserNameUpdateNotificationStorage, User> 
}

@UserInfoRepresentable
struct UserNameUpdateNotificationStorage {
    let oldName: String
    let newName: String
}
```

## How to Use
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
TypedNotificationCenter.default.publisher(for: .userNameWillUpdate, object: user)
    .sink { notification in
        // Notifications can be received in a type safe manner.
        let newName = notification.storage
        let user: User? = notification.object
        // ...
    }
```

### Notification macro

You can use `@Notification` macro, if `@UserInforRepresentable` macro is attached to your type.
```swift
extension TypedNotificationDefinition {
    @Notification
    static var userNameUpdate: TypedNotificationDefinition<UserNameUpdateNotificationStorage, User> 
}

@UserInfoRepresentable
struct UserNameUpdateNotificationStorage {
    let oldName: String
    let newName: String
}
```

## Pre-defined Notifications
This repository contains frequent system notifications.
- UIKit
    - [UIApplication](Sources/TypedNotifications/UIKit/UIApplication.swift)
    - [UIScene](Sources/TypedNotifications/UIKit/UIScene.swift)
    - [UIResponder](Sources/TypedNotifications/UIKit/UIResponder.swift)

Your PR adding new notifications is appreciated. Feel free to make a new PR.
