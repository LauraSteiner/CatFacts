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
	//@State var breeds: [CatBreed] = []
	@State var total: Int = 0

    var body: some View {
		NavigationStack{
			VStack {
				List {
					ForEach(catVM.breeds) { breed in
						LazyVStack{
							NavigationLink(destination: DetailView(breed: breed)) {
								Text(breed.breed)
							}
							.task{
								print("In task to check if need to load more cats")
								await catVM.loadNextIfNeeded(breed: breed)
								//breeds = catVM.breeds
							}
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
			//breeds = catVM.breeds
			//total = catVM.total
		}
		.toolbar{
			ToolbarItem(placement: .bottomBar) {
				Text("\(catVM.breeds.count) of \(catVM.total) breeds")
			}
		}
    }
}

#Preview {
    ListView()
}

/*
 List (searchResults){ creature in
 LazyVStack{
 NavigationLink {
 DetailView(creature: creature)
 } label: {
 Text("\(returnIndex(of: creature)). \(creature.name.capitalized)")
 .font(.title2)
 }
 }
 .task{
 await creatures.loadNextIfNeeded(creature: creature)
 }
 }
 */
