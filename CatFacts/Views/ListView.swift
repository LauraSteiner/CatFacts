//
//  ContentView.swift
//  CatFacts
//
//  Created by Laura Steiner on 6/17/25.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Environment(\.modelContext) private var modelContext
    @State var catVM = CatViewModel()
	@State var breeds: [CatBreed] = []

    var body: some View {
		NavigationStack{
			VStack {
				List {
					ForEach(breeds) { breed in
						Text(breed.breed)
					}
				}
			}
		}
		.task{@MainActor in
			await catVM.getData()
			breeds = catVM.breeds
		}
    }
}

#Preview {
    ListView()
}
