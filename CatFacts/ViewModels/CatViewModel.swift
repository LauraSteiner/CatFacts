//
//  CatViewModel.swift
//  CatFacts
//
//  Created by Laura Steiner on 6/17/25.
//

import Foundation

@Observable
class CatViewModel: Codable {
	var urlString = "https://catfact.ninja/breeds"
	var isLoading = false
	var currentPage: Int = 3 // for testing, set at 3
	var breeds: [CatBreed] = []
	var total: Int = 0
	var nextPageUrl:  String = ""
	
	private struct Returned: Codable {
		var data: [CatBreed]
		var next_page_url: String?
		var current_page: Int
		var total: Int
	}
	
	func getData() async {
		isLoading = true
		print("🕸️ In getData, url strin is \(urlString)")
		guard let url = URL(string: urlString) else {
			print("ERROR -- Could not create URL from \(urlString)")
			isLoading = false
			return
		}
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
				print("ERROR -- could not decode data from \(urlString)")
				isLoading = false
				return
			}
			Task { @MainActor in
				self.breeds = self.breeds + returned.data
				//self.nextPageUrl = returned.next_page_url ?? ""
				self.urlString = returned.next_page_url ?? ""
				self.currentPage = returned.current_page
				self.total = returned.total
				isLoading = false
				print("Current page is \(self.currentPage)")
			}
			
		} catch {
			print("ERROR -- Could not get data from \(urlString): \(error.localizedDescription)")
			isLoading = false
		}
	}
	
	func loadAll() async {
		Task { @MainActor in
			guard urlString.hasPrefix("http") else {
				return
			}
			
			await getData()
			await loadAll()
		}
	}
	
	func loadNextIfNeeded(breed: CatBreed) async {
		print("Breed is \(breed.breed)")
		guard let lastBreed = breeds.last else { return }
		print("last breed is \(lastBreed.breed)")
		print("Url string is \(urlString)")
		if breed.id == lastBreed.id && urlString.hasPrefix("http"){
			print("last breed loaded")
			await getData()
		}
	}
}
