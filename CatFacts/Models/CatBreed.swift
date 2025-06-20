//
//  CatBreed.swift
//  CatFacts
//
//  Created by Laura Steiner on 6/17/25.
//

import Foundation

class CatBreed: Identifiable, Codable {
	let id = UUID().uuidString
	var breed: String = ""
	var country: String = ""
	var origin: String = ""
	var coat: String = ""
	var pattern: String = ""
	
	enum CodingKeys: CodingKey {
		case breed
		case country
		case origin
		case coat
		case pattern
	}
	
	init(
		breed: String = "",
		country: String = "",
		origin: String = "",
		coat: String = "",
		pattern: String = ""
	) {
		self.breed = breed
		self.country = country
		self.origin = origin
		self.coat = coat
		self.pattern = pattern
	}
}
