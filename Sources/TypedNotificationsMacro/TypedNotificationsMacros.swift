import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct TypedNotificationsMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        NotificationMacro.self
    ]
}
