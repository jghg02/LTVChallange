//
//  DataBinding.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 10-12-21.
//

final class DataBiding<T> {

  typealias Listener = (T) -> Void
  var listener: Listener?
  
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  init(_ value: T) {
    self.value = value
  }
  
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
