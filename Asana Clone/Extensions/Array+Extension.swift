//
//  Array+Extension.swift
//  Asana Clone
//
//  Created by Nick on 7/12/23.
//

extension Array {
	func isIndexValid(index: Index) -> Bool {
		return self.endIndex > index && self.startIndex <= index
	}
}
