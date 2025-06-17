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
			catImage
		}
		.listStyle(.plain)
		.font(.title2)
		.navigationTitle(breed.breed)
		//.padding()
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

extension DetailView{
	var imageURL: String{
		ImageURL.breedImages[breed.breed] ?? ""
	}
	var catImage: some View {
		VStack{
			if imageURL.isEmpty {
				ImageNotAvailable()
			}
			else {
				AsyncImage(url: URL(string: imageURL), content: { phase in
					if let image = phase.image {
						image
							.resizable()
							.scaledToFit()
					} else if phase.error != nil {
						ImageNotAvailable()
					} else {
						ProgressView()
							.tint(.red)
							.scaleEffect(4)
							.frame(maxWidth: .infinity)
							.frame(height: 250)
					}
				})
			}
		}
	}
}

struct ImageNotAvailable: View {
	var body: some View {
		HStack{
			Spacer()
			VStack{
				Image(systemName: "rectangle.slash")
					.resizable()
					.scaledToFit()
					.foregroundStyle(.secondary)
					.fontWeight(.thin)
					.frame(height: 200)
				Text("Image not available")
			}
			Spacer()
		}
	}
}
