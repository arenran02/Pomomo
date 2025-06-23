import SwiftUI

struct ContentView: View {
    @State private var task: String = ""
    @State private var isEditingTask = true
    @State private var timeRemaining = 3600
    @State private var totalTime = 3600
    @State private var timerRunning = false
    @State private var timer: Timer?

    var progress: Double {
        Double(timeRemaining) / Double(totalTime)
    }

    var body: some View {
        VStack(spacing: 40) {
            if isEditingTask {
                TextField("할 일을 입력하세요", text: $task, onCommit: {
                    isEditingTask = false
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            } else {
                Text(task)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .onTapGesture(count: 2) {
                        isEditingTask = true
                    }
            }

            PomodoroTimerView(progress: 1.0 - progress
                              /*timeText: formatTime(timeRemaining)*/)

            HStack(spacing: 30) {
                Button(action: {
                    timerRunning ? pauseTimer() : startTimer()
                }) {
                    Label(timerRunning ? "정지" : "시작",
                          systemImage: timerRunning ? "pause.fill" : "play.fill")
                }

                Button(action: resetTimer) {
                    Label("리셋", systemImage: "arrow.counterclockwise")
                }
            }
            .font(.title2)
        }
        .padding()
    }
    
    func startTimer() {
        guard !timerRunning else { return }
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timerRunning = false
            }
        }
    }

    func pauseTimer() {
        timer?.invalidate()
        timerRunning = false
    }

    func resetTimer() {
        timer?.invalidate()
        timeRemaining = totalTime
        timerRunning = false
    }
}
