import SwiftUI

struct PomodoroTimerView: View {
    var progress: Double
//    var timeText: String

    var body: some View {
        ArcProgressView(progress: progress)
    }
}
