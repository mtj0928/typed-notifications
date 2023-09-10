import SwiftUI

struct ContentView: View {
    @State var text = ""

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            TextField("textfield", text: $text)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
