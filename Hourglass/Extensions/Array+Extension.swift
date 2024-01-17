extension Array {
	func isIndexValid(index: Index) -> Bool {
		return self.endIndex > index && self.startIndex <= index
	}
}
