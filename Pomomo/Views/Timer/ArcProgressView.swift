import SwiftUI


struct ArcProgressView: View {
    var progress: Double // 0.0 ~ 1.0
    let totalMinutes = 60

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.red)
                .frame(width: 240, height: 240)

            // 진행된 시간 부채꼴
            SectorShape(progress: progress)
                .fill(Color.white)
                .rotationEffect(.degrees(-90))
                .clipShape(Circle())

            // 눈금 + 숫자
            ForEach(0..<totalMinutes) { minute in
                let angle = Angle(degrees: -Double(minute) / Double(totalMinutes) * 360)

                VStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: minute % 10 == 0 ? 5 : 2,
                               height: minute % 10 == 0 ? 20 :
                                       minute % 5 == 0 ? 10 : 5)
                        .opacity(minute % 5 == 0 ? 0.8 : 0.4)

                    // 10분 단위에 숫자 추가
                    if minute % 5 == 0 {
                        Text("\(minute)")
                            .font(.caption2)
                            .foregroundColor(.black)
                            .rotationEffect(-angle) // 글자가 회전되지 않도록 보정
                            .offset(y: -50)
                            
                    }
                }
                .offset(y: -(120 - (minute % 10 == 0 ? 5 : minute % 5 == 0 ? 0 : -10)))
                .rotationEffect(angle)
            }

            Rectangle()
                .fill(Color.red)
                .frame(width: 2, height: 110)
                .offset(y: -55)
                .rotationEffect(.degrees(progress * 360 - 90))
        }
        .frame(width: 300, height: 300)
    }
}
