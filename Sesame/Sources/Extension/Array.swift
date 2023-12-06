// Array.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 06/12/2023

import Foundation

extension Array where Element: Hashable {
  func removingDuplicates<T: Hashable>(basedOn keyPath: KeyPath<Element, T>) -> [Element] {
    var seen = Set<T>()
    return filter { seen.insert($0[keyPath: keyPath]).inserted }
  }
}
