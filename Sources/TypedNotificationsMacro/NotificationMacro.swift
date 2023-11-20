import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct TypedNotificationsMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        NotificationMacro.self
    ]
}

public struct NotificationMacro: AccessorMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {
        guard let variableDeclSyntax = declaration.as(VariableDeclSyntax.self) else {
            context.addDiagnostics(
                from: MessageError(description: "@Notification supports only variable."),
                node: declaration
            )
            return []
        }

        guard let binding = variableDeclSyntax.bindings.first else {
            context.addDiagnostics(
                from: MessageError(description: "@Notification requires a binding"),
                node: variableDeclSyntax
            )
            return []
        }

        guard variableDeclSyntax.bindings.count == 1 else {
            context.addDiagnostics(
                from: MessageError(description: "@Notification doesn't support multiple binding"),
                node: variableDeclSyntax.bindings
            )
            return []
        }

        guard let type = binding.typeAnnotation?.type else {
            context.addDiagnostics(
                from: MessageError(description: "@Notification requires type annotation."),
                node: binding
            )
            return []
        }

        let name: any SyntaxProtocol
        if let labeledNameNode = node.arguments?.as(LabeledExprListSyntax.self)?.first?.expression {
            name = labeledNameNode
        } else if let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier {
            name = StringLiteralExprSyntax(content: identifier.text)
        } else {
            context.addDiagnostics(
                from: MessageError(description: "No name information."),
                node: binding
            )
            return []
        }

        return [
            """
            get {
                \(type)(name: \(name))
            }
            """
        ]
    }
}

struct MessageError: Error, CustomStringConvertible {
    var description: String
}
