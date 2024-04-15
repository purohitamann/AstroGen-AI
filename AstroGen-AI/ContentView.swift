import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
  let model = GenerativeModel(name: "gemini-pro", apiKey: "") // Replace "" with your API key
  @State var textInput = ""
  @State var aiResponse = "Hello! I am your personal Astrologer. How can I help you today?"

  var body: some View {
    VStack {
      ScrollView {
        Text(aiResponse)
          .font(.largeTitle)
          .multilineTextAlignment(.center)
      }
      HStack {
        TextField("Enter a message", text: $textInput)
          .textFieldStyle(.roundedBorder)
          .foregroundColor(.black)
          .onSubmit { // Capture Enter key press
         sendMessage()
          }
        Button(action: sendMessage, label: { Text("Send") }) // Optional Send button
      }
    }
    .foregroundColor(.white)
    .padding()
    .background {
      ZStack {
        Color.black
      }
      .ignoresSafeArea()
    }
  }

  func sendMessage() {
    aiResponse = ""
    Task {
      do {
        let response = try await model.generateContent(textInput)
        guard let text = response.text else {
          textInput = "Sorry, I could not process that. \nPlease try again."
          return
        }
        textInput = ""
        aiResponse = text
      } catch {
        aiResponse = "Something went wrong! \n\(error.localizedDescription)"
      }
    }
  }
}

#Preview {
  ContentView()
}
