//
//  FactViewModel.swift
//  CatFacts
//
//  Created by Laura Steiner on 6/17/25.
//

import Foundation

@Observable
class FactViewModel{
	var fact: String = ""
	var isLoading = false
	var urlString = "https://catfact.ninja/fact"
	
	private struct Returned: Codable {
		var fact: String
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
				self.fact = returned.fact
				isLoading = false
			}
			
		} catch {
			print("ERROR -- Could not get data from \(urlString): \(error.localizedDescription)")
			isLoading = false
		}
	}
}
