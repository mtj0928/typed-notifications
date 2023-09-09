import XCTest
@testable import TypedNotifications

final class TypedNotificationsTests: XCTestCase {

    @available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
    func testNotifications() async {
        Task {
            try await Task.sleep(nanoseconds: 1_000)
            let foo = Foo(value: "sender")
            TypedNotificationCenter.default.post(.foo, storage: 123, object: foo)
        }
        let notification = await TypedNotificationCenter.default.notifications(for: .foo).first(where: { _ in true })
        XCTAssertEqual(notification?.name.rawValue, "Foo")
        XCTAssertEqual(notification?.storage, 123)
        XCTAssertEqual(notification?.object?.value, "sender")
    }

    func testNotifications() {
        let expectation = expectation(description: "receive a foo notification")
        let cancellable = TypedNotificationCenter.default.publisher(for: .foo)
            .sink { notification in
                XCTAssertEqual(notification.name.rawValue, "Foo")
                XCTAssertEqual(notification.storage, 123)
                XCTAssertEqual(notification.object?.value, "sender")
                expectation.fulfill()
            }
        let foo = Foo(value: "sender")
        TypedNotificationCenter.default.post(.foo, storage: 123, object: foo)
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
}
