//
//  SongStack.swift
//  AudioPlayer
//
//  Created by Daniel Yamrak on 17.09.2021.
//

import Foundation

struct SongStack<T> {
    private var stack = Array<T>()
    private let _maxSize: Int
    var count: Int {
        return stack.count
    }

    public init(maxSize: Int){
        self._maxSize = maxSize
    }

    public func peek() -> T? {
        return stack.first ?? nil;
    }

    public func getElement(by index: Int) -> T {
        if index < stack.count && index >= 0 {
            return stack[index]
        } else {
            fatalError("Error getting index")
        }
    }

    public func last() -> T? {
        if !stack.isEmpty {
            return stack[stack.count - 1]
        } else { return nil }
    }

    public func isFull() -> Bool {
        stack.count == _maxSize
    }

    public func isEmpty() -> Bool {
        stack.count == 0
    }

    mutating public func push(_ v: T) -> Void {
        guard !isFull() else {
            print("Could not insert data, Stack is full.")
            return
        }
        stack.insert(v, at: 0)
    }

    mutating public func pop() -> T? {
        guard !isEmpty() else {
            print("Could not retrieve data, Stack is empty.")
            return nil
        }
        let v = stack.remove(at: 0)
        return v
    }

    public func getAllStack() -> Array<T> {
        return self.stack
    }

}
