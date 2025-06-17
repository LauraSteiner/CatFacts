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
	@State var total: Int = 0
	@State private var sheetIsShowing = false

    var body: some View {
		NavigationStack{
			ZStack {
				VStack {
					List {
						ForEach(catVM.breeds) { breed in
							LazyVStack{
								NavigationLink(destination: DetailView(breed: breed)) {
									Text(breed.breed)
								}
								.task{
									await catVM.loadNextIfNeeded(breed: breed)
								}
							}
						}
					}
					.listStyle(.plain)
				}
				.font(.title2)
				.navigationTitle("Cat Breeds")
				if catVM.isLoading {
					ProgressView()
						.tint(.red)
						.scaleEffect(4)
				}
			}
			.toolbar{
				ToolbarItem(placement: .topBarTrailing) {
					Button {
						sheetIsShowing.toggle()
					} label: {
						HStack{
							Text("🐈‍⬛")
							Image(systemName: "lightbulb.fill")
						}
					}
					.buttonStyle(.bordered)

				}
				ToolbarItem(placement: .status) {
					Text("\(catVM.breeds.count) of \(catVM.total) breeds")
				}
				ToolbarItem(placement: .bottomBar) {
					Button("Load all") {
						Task{ @MainActor in
							await catVM.loadAll()
						}
					}
					.buttonStyle(.borderedProminent)
				}
			}
		}
		.task{@MainActor in
			await catVM.getData()
		}
		.sheet(isPresented: $sheetIsShowing){
			FactView()
		}

    }
}

#Preview {
    ListView()
}
