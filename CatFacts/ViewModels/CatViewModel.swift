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
	//var nextPageUrl:  String? = ""
	
	private struct Returned: Codable {
		var data: [CatBreed]
		//var next_page_url: String?
		var current_page: Int
	}
	
	func getData() async {
		isLoading = true
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
				self.breeds = returned.data
				//self.nextPageUrl = returned.next_page_url
				self.currentPage = returned.current_page
				isLoading = false
				print("Current page is \(self.currentPage)")
			}
			
		} catch {
			print("ERROR -- Could not get data from \(urlString): \(error.localizedDescription)")
			isLoading = false
		}
	}
	
	
}
