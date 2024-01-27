import CoreData
import UserInfoRepresentable

extension NSManagedObjectContext {
    /// A notification that the context is about to save.
    @Notification(name: NSManagedObjectContext.willSaveObjectsNotification.rawValue)
    public static var willSaveObjectsTypedNotification:
    TypedNotificationDefinition<NSManagedObjectNotificationUserInfo, NSManagedObjectContext>

    /// A notification that posts when the context completes a save.
    @Notification(name: NSManagedObjectContext.didSaveObjectsNotification.rawValue)
    public static var didSaveObjectsTypedNotification:
    TypedNotificationDefinition<NSManagedObjectNotificationUserInfo, NSManagedObjectContext>

    /// A notification that posts when the context completes a save.
    @Notification(name: NSManagedObjectContext.didChangeObjectsNotification.rawValue)
    public static var didChangeObjectsTypedNotification:
    TypedNotificationDefinition<NSManagedObjectNotificationUserInfo, NSManagedObjectContext>
}

public struct NSManagedObjectNotificationUserInfo: UserInfoRepresentable {
    /// The set of objects that were inserted into the context.
    public var insertedObjects: Set<NSManagedObject>

    /// The set of objects that were updated.
    public var updatedObjects: Set<NSManagedObject>

    /// The set of objects that were marked for deletion during the previous event.
    public var deletedObjects: Set<NSManagedObject>

    /// The set of objects that were refreshed but were not dirtied in the scope of this context.
    public var refreshedObjects: Set<NSManagedObject>

    /// The set of objects that were invalidated.
    public var invalidatedObjects: Set<NSManagedObject>

    public init(
        insertedObjects: Set<NSManagedObject>,
        updatedObjects: Set<NSManagedObject>,
        deletedObjects: Set<NSManagedObject>,
        refreshedObjects: Set<NSManagedObject>,
        invalidatedObjects: Set<NSManagedObject>
    ) {
        self.insertedObjects = insertedObjects
        self.updatedObjects = updatedObjects
        self.deletedObjects = deletedObjects
        self.refreshedObjects = refreshedObjects
        self.invalidatedObjects = invalidatedObjects
    }

    public init(userInfo: [AnyHashable : Any]) throws {
        insertedObjects = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject> ?? []
        updatedObjects = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject> ?? []
        deletedObjects = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject> ?? []
        refreshedObjects = userInfo[NSRefreshedObjectsKey] as? Set<NSManagedObject> ?? []
        invalidatedObjects = userInfo[NSInvalidatedObjectsKey] as? Set<NSManagedObject> ?? []
    }
    
    public func convertToUserInfo() -> [AnyHashable : Any] {
        [
            NSInsertedObjectsKey: insertedObjects,
            NSUpdatedObjectsKey: updatedObjects,
            NSDeletedObjectsKey: deletedObjects,
            NSRefreshedObjectsKey: refreshedObjects,
            NSInvalidatedObjectsKey: invalidatedObjects,
        ]
    }
}
