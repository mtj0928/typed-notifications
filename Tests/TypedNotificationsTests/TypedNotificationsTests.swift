import XCTest
@testable import TypedNotifications

final class TypedNotificationsTests: XCTestCase {

    @available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
    func testNotifications() async {
        let center = TypedNotificationCenter()
        let expectationA = expectation(description: "Task is called")
        let expectationB = expectation(description: "receive a foo notification")
        Task {
            expectationA.fulfill()
            let notification = await center.notifications(for: .foo).first(where: { _ in true })
            XCTAssertEqual(notification?.name.rawValue, "Foo")
            XCTAssertEqual(notification?.storage, 123)
            XCTAssertEqual(notification?.object?.value, "sender")
            expectationB.fulfill()
        }
        await fulfillment(of: [expectationA], timeout: 1)
        let foo = Foo(value: "sender")
        center.post(.foo, storage: 123, object: foo)
        await fulfillment(of: [expectationB], timeout: 1)
    }

    func testPublishers() {
        let center = TypedNotificationCenter()
        let expectation = expectation(description: "receive a foo notification")
        let cancellable = center.publisher(for: .foo)
            .sink { notification in
                XCTAssertEqual(notification.name.rawValue, "Foo")
                XCTAssertEqual(notification.storage, 123)
                XCTAssertEqual(notification.object?.value, "sender")
                expectation.fulfill()
            }
        let foo = Foo(value: "sender")
        center.post(.foo, storage: 123, object: foo)
        wait(for: [expectation], timeout: 1)
        _ = cancellable
    }

    func testNoStorage() {
        let center = TypedNotificationCenter()
        let expectation = expectation(description: "receive an empty notification")
        let cancellable = center.publisher(for: .noStorage)
            .sink { notification in
                XCTAssertEqual(notification.name.rawValue, "noStorage")
                XCTAssertEqual(notification.object?.value, "sender")
                expectation.fulfill()
            }
        let foo = Foo(value: "sender")
        center.notificationCenter.post(name: .init("noStorage"), object: foo, userInfo: [:])
        wait(for: [expectation], timeout: 1)
        _ = cancellable
    }
}

class Foo {
    let value: String

    init(value: String) {
        self.value = value
    }
}

extension TypedNotificationDefinition {
    static var foo: TypedNotificationDefinition<Int, Foo> {
        .init(name: "Foo") { number in
            ["number": number]
        } decode: { userInfo in
            userInfo!["number"] as! Int
        }
    }

    static var noStorage: TypedNotificationDefinition<Void, Foo> {
        .init(name: "noStorage")
    }
}
