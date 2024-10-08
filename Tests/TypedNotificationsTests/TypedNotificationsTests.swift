import XCTest
import UserInfoRepresentable
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

    func testCustomUserInfo() {
        let center = TypedNotificationCenter()
        let expectation = expectation(description: "receive an empty notification")
        let cancellable = center.publisher(for: .customUserInfo)
            .sink { notification in
                XCTAssertEqual(notification.name.rawValue, "customUserInfo")
                XCTAssertEqual(notification.object?.value, "sender")
                XCTAssertEqual(notification.storage.value, "userInfo")
                expectation.fulfill()
            }
        let foo = Foo(value: "sender")
        center.post(.customUserInfo, storage: CustomUserInfo(value: "userInfo"), object: foo)
        wait(for: [expectation], timeout: 1)
        _ = cancellable
    }

    func testMacro() throws {
#if canImport(TypedNotificationsMacro)
        let center = TypedNotificationCenter()
        let expectation = expectation(description: "receive an empty notification")
        let cancellable = center.publisher(for: .macroNotification)
            .sink { notification in
                XCTAssertEqual(notification.name.rawValue, "macroNotification")
                XCTAssertEqual(notification.object?.value, "sender")
                expectation.fulfill()
            }
        let foo = Foo(value: "sender")
        center.post(.macroNotification, object: foo)
        wait(for: [expectation], timeout: 1)
        _ = cancellable
#else
        throw XCTSkip("Macro is not support on the current test environment.")
#endif
    }

    func testMacroWithName() throws {
#if canImport(TypedNotificationsMacro)
        let center = TypedNotificationCenter()
        let expectation = expectation(description: "receive an empty notification")
        let cancellable = center.publisher(for: .macroNotificationWithName)
            .sink { notification in
                XCTAssertEqual(notification.name.rawValue, "customName")
                XCTAssertEqual(notification.object?.value, "sender")
                XCTAssertEqual(notification.storage.value, "userInfo")
                expectation.fulfill()
            }
        let foo = Foo(value: "sender")
        center.post(.macroNotificationWithName, storage: CustomUserInfo(value: "userInfo"), object: foo)
        wait(for: [expectation], timeout: 1)
        _ = cancellable
#else
        throw XCTSkip("Macro is not support on the current test environment.")
#endif
    }
}

final class Foo: Sendable {
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

    static var customUserInfo: TypedNotificationDefinition<CustomUserInfo, Foo> {
        .init(name: "customUserInfo")
    }

    @Notification
    static var macroNotification: TypedNotificationDefinition<Void, Foo>

    @Notification(name: "customName")
    static var macroNotificationWithName: TypedNotificationDefinition<CustomUserInfo, Foo>
}


@UserInfoRepresentable
struct CustomUserInfo {
    let value: String

    init(value: String) {
        self.value = value
    }
}
