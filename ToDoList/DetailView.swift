//
//  DetailView.swift
//  ToDoList
//
//  Created by GuitarLearnerJas on 18/9/2024.
//

import SwiftUI

struct DetailView: View {
    var passedValue: String
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
            Text("You are a true Swifty Legend!\nAnd this is \(passedValue)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Spacer()
            Button("Back To Main") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationBarHidden(false)
    }
}

#Preview {
    DetailView(passedValue: "PassedValue")
}
