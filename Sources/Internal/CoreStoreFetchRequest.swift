//
//  CoreStoreFetchRequest.swift
//  CoreStore
//
//  Copyright © 2016 John Rommel Estropia
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation
import CoreData


// MARK: - CoreStoreFetchRequest

// Bugfix for NSFetchRequest messing up memory management for `affectedStores`
// http://stackoverflow.com/questions/14396375/nsfetchedresultscontroller-crashes-in-ios-6-if-affectedstores-is-specified
internal final class CoreStoreFetchRequest<T: NSFetchRequestResult>: NSFetchRequest<NSFetchRequestResult> {
    
    // MARK: Internal
    
    @nonobjc
    internal func dynamicCast<U: NSFetchRequestResult>() -> NSFetchRequest<U> {
        
        return unsafeBitCast(self, to: NSFetchRequest<U>.self)
    }
    
    
    // MARK: NSFetchRequest
    
    @objc
    dynamic override var affectedStores: [NSPersistentStore]? {
        
        get {
            
            // This forced-casting is needed to fix an ARC bug with "affectedStores" mis-retaining the array
            let affectedStores: NSArray? = super.affectedStores.flatMap({ NSArray(array: $0) } )
            return affectedStores as? [NSPersistentStore]
        }
        set {
            
            super.affectedStores = newValue
        }
    }
}
