//
//  Encodable+Extension.swift
//  Asana Clone
//
//  Created by Nick on 7/17/23.
//

import Foundation

extension Encodable {
	var dictionary: [String: Any]? {
		guard let data = try? JSONEncoder().encode(self) else { return nil }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
	}
}
