//
//  Slider.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/12.
//

import SwiftUI

struct SliderView: View {
    var min: Double
    var max: Double
    var step: Double
    @Binding var valueInt: Int
    @State private var value: Double
    @State private var isEditing = false

    init(min: Double, max: Double, step: Double, value: Double, bindValue: Binding<Int>) {
        self.min = min
        self.max = max
        self.step = step
        self._value = State(initialValue: value)
        self._valueInt = bindValue
    }

    var body: some View {
        HStack {
            Slider(
                value: $value,
                in: min...max,
                step: step
            ) {} onEditingChanged: { editing in
                isEditing = editing
                valueInt = Int(value)
            }
            Text(" \(Int(value))")
                .frame(width: 40)
        }
        .padding(.horizontal, 3.0)
    }
}

#Preview {
    SliderView(min: 40, max: 180, step: 5, value: 90, bindValue: .constant(10))
}
