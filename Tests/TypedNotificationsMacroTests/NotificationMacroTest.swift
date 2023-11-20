import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(TypedNotificationsMacro)
import TypedNotificationsMacro

let testMacros: [String: Macro.Type] = [
    "Notification": NotificationMacro.self,
]
#endif

final class NotificationMacroTests: XCTestCase {

    func testNotificationMacro() throws {
#if canImport(TypedNotificationsMacro)
        assertMacroExpansion(
            """
            @Notification
            static var userWillUpdate: TypedNotificationDefinition<String, User>
            """,
            expandedSource: 
            """
            static var userWillUpdate: TypedNotificationDefinition<String, User> {
                get {
                    TypedNotificationDefinition<String, User>(name: "userWillUpdate")
                }
            }
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func testNotificationWithGivenNameMacro() throws {
#if canImport(TypedNotificationsMacro)
        assertMacroExpansion(
            """
            @Notification("custom")
            static var userWillUpdate: TypedNotificationDefinition<String, User>
            """,
            expandedSource:
            """
            static var userWillUpdate: TypedNotificationDefinition<String, User> {
                get {
                    TypedNotificationDefinition<String, User>(name: "custom")
                }
            }
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
}
