//
//  SectorShape.swift
//  Pomomo
//
//  Created by kim on 6/23/25.
//


import SwiftUI

struct SectorShape: Shape {
    var progress: Double // 0.0 ~ 1.0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let endAngle = Angle(degrees: 360 * progress)

        path.move(to: center)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: .degrees(0),
                    endAngle: endAngle,
                    clockwise: false)
        path.closeSubpath()
        return path
    }
}