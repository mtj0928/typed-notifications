# typed-notifications
A library attaching type-information to `NotificationCenter`

This library is attaching type-information to `NotificationCenter`.
You can post and observe notifications in a type-safe manner.

## How to use
Define a notification and how to encode/decode the userInfo.
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

class User {
    var name = "name"
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
        let user: User? = notification.object
        let newName = notification.storage
        // ...
    }
```
