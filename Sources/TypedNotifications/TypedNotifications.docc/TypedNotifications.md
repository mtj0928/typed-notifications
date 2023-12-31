# ``TypedNotifications``

A library attaching type-information to `NotificationCenter`

## Overview
This library attaches type-information to `NotificationCenter`.
You can post and observe notifications in a type-safe manner.

```swift
TypedNotificationCenter.default
    .publisher(for: .userNameUpdate, object: user)
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

## Usage
Define a notification and how to encode/decode the userInfo in `TypedNotificationDefinition`.
```swift
extension TypedNotificationDefinition {
    static var userNameUpdate: TypedNotificationDefinition<String, User> {
        .init(name: "userNameUpdate") { newName in
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
TypedNotificationCenter.default.post(.userNameUpdate, storage: newName, object: user)

// [Observation]
TypedNotificationCenter.default
    .publisher(for: .userNameUpdate, object: user)
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
