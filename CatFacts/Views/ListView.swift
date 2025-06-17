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
	@State var total: Int = 0

    var body: some View {
		NavigationStack{
			VStack {
				List {
					ForEach(breeds) { breed in
						NavigationLink(destination: DetailView(breed: breed)) {
							Text(breed.breed)
						}
					}
				}
				.listStyle(.plain)
			}
			.font(.title2)
			.navigationTitle("Cat Breeds")
		}
		.task{@MainActor in
			await catVM.getData()
			breeds = catVM.breeds
			total = catVM.total
		}
		.toolbar{
			ToolbarItem(placement: .bottomBar) {
				Text("\(breeds.count) of \(total) breeds")
			}
		}
    }
}

#Preview {
    ListView()
}
