//
//  DetailView.swift
//  CatFacts
//
//  Created by Laura Steiner on 6/17/25.
//

import SwiftUI

struct DetailView: View {
	let breed: CatBreed
	
	var body: some View {
		List{
			InfoRow(label: "Country", value: breed.country)
			InfoRow(label: "Origin", value: breed.origin)
			InfoRow(label: "Coat", value: breed.coat)
			InfoRow(label: "Pattern", value: breed.pattern)
		}
		.listStyle(.plain)
		.font(.title2)
		.navigationTitle(breed.breed)
	}
}


#Preview {
	let testBreed = CatBreed(
		breed : "Burmese",
		country: "Burma & Thailand",
		origin: "Natural",
		coat: "Short",
		pattern: "Solid"
	)
	
	NavigationStack{
		DetailView(breed: testBreed)
	}
}

struct InfoRow: View {
	let label: String
	let value: String
	
	var body: some View {
		HStack{
			Text(label)
				.bold()
			Spacer()
			Text(value)
		}
	}
}
