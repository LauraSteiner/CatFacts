//
//  FactView.swift
//  CatFacts
//
//  Created by Laura Steiner on 6/17/25.
//

import SwiftUI

struct FactView: View {
	@State var factVM = FactViewModel()
	@Environment(\.dismiss) var dismiss
    var body: some View {
		VStack(spacing: 10){
			Text("🐈 Cat fact:")
				.bold()
				.font(.system(size: 42))
			Text(factVM.fact)
				.font(.title2)
				.multilineTextAlignment(.center)
			Button {
				dismiss()
			} label: {
				Text("Dismiss")
			}
			.buttonStyle(.borderedProminent)

		}
		.padding()
		.task{
			await factVM.getData()
		}
		.presentationDetents([.medium])
    }
}

#Preview {
    FactView()
}
