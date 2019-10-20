//
//  CoreStore+Observing.swift
//  CoreStore
//
//  Copyright © 2018 John Rommel Estropia
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


// MARK: - CoreStore

@available(*, deprecated, message: "Call methods directly from the DataStack instead")
@available(macOS 10.12, *)
extension CoreStore {
    
    /**
     Using the `CoreStoreDefaults.dataStack`, creates an `ObjectMonitor` for the specified `DynamicObject`. Multiple `ObjectObserver`s may then register themselves to be notified when changes are made to the `DynamicObject`.
     
     - parameter object: the `DynamicObject` to observe changes from
     - returns: an `ObjectMonitor` that monitors changes to `object`
     */
    public static func monitorObject<O: DynamicObject>(_ object: O) -> ObjectMonitor<O> {
        
        return CoreStoreDefaults.dataStack.monitorObject(object)
    }
    
    /**
     Using the `CoreStoreDefaults.dataStack`, creates a `ListMonitor` for a list of `DynamicObject`s that satisfy the specified fetch clauses. Multiple `ListObserver`s may then register themselves to be notified when changes are made to the list.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for fetching the object list. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: a `ListMonitor` instance that monitors changes to the list
     */
    public static func monitorList<D>(_ from: From<D>, _ fetchClauses: FetchClause...) -> ListMonitor<D> {
        
        return CoreStoreDefaults.dataStack.monitorList(from, fetchClauses)
    }
    
    /**
     Using the `CoreStoreDefaults.dataStack`, creates a `ListMonitor` for a list of `DynamicObject`s that satisfy the specified fetch clauses. Multiple `ListObserver`s may then register themselves to be notified when changes are made to the list.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for fetching the object list. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: a `ListMonitor` instance that monitors changes to the list
     */
    public static func monitorList<D>(_ from: From<D>, _ fetchClauses: [FetchClause]) -> ListMonitor<D> {
        
        return CoreStoreDefaults.dataStack.monitorList(from, fetchClauses)
    }
    
    /**
     Creates a `ListMonitor` for a list of `DynamicObject`s that satisfy the specified `FetchChainableBuilderType` built from a chain of clauses.
     ```
     let monitor = dataStack.monitorList(
         From<MyPersonEntity>()
             .where(\.age > 18)
             .orderBy(.ascending(\.age))
     )
     ```
     - parameter clauseChain: a `FetchChainableBuilderType` built from a chain of clauses
     - returns: a `ListMonitor` for a list of `DynamicObject`s that satisfy the specified `FetchChainableBuilderType`
     */
    public static func monitorList<B: FetchChainableBuilderType>(_ clauseChain: B) -> ListMonitor<B.ObjectType> {
        
        return CoreStoreDefaults.dataStack.monitorList(clauseChain.from, clauseChain.fetchClauses)
    }
    
    /**
     Using the `CoreStoreDefaults.dataStack`, asynchronously creates a `ListMonitor` for a list of `DynamicObject`s that satisfy the specified fetch clauses. Multiple `ListObserver`s may then register themselves to be notified when changes are made to the list. Since `NSFetchedResultsController` greedily locks the persistent store on initial fetch, you may prefer this method instead of the synchronous counterpart to avoid deadlocks while background updates/saves are being executed.
     
     - parameter createAsynchronously: the closure that receives the created `ListMonitor` instance
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for fetching the object list. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     */
    public static func monitorList<D>(createAsynchronously: @escaping (ListMonitor<D>) -> Void, _ from: From<D>, _ fetchClauses: FetchClause...) {
        
        CoreStoreDefaults.dataStack.monitorList(createAsynchronously: createAsynchronously, from, fetchClauses)
    }
    
    /**
     Using the `CoreStoreDefaults.dataStack`, asynchronously creates a `ListMonitor` for a list of `DynamicObject`s that satisfy the specified fetch clauses. Multiple `ListObserver`s may then register themselves to be notified when changes are made to the list. Since `NSFetchedResultsController` greedily locks the persistent store on initial fetch, you may prefer this method instead of the synchronous counterpart to avoid deadlocks while background updates/saves are being executed.
     
     - parameter createAsynchronously: the closure that receives the created `ListMonitor` instance
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for fetching the object list. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     */
    public static func monitorList<D>(createAsynchronously: @escaping (ListMonitor<D>) -> Void, _ from: From<D>, _ fetchClauses: [FetchClause])  {
        
        CoreStoreDefaults.dataStack.monitorList(createAsynchronously: createAsynchronously, from, fetchClauses)
    }
    
    /**
     Asynchronously creates a `ListMonitor` for a list of `DynamicObject`s that satisfy the specified `FetchChainableBuilderType` built from a chain of clauses. Since `NSFetchedResultsController` greedily locks the persistent store on initial fetch, you may prefer this method instead of the synchronous counterpart to avoid deadlocks while background updates/saves are being executed.
     
     ```
     dataStack.monitorList(
         createAsynchronously: { (monitor) in
             self.monitor = monitor
         },
         From<MyPersonEntity>()
             .where(\.age > 18)
             .orderBy(.ascending(\.age))
     )
     ```
     - parameter createAsynchronously: the closure that receives the created `ListMonitor` instance
     - parameter clauseChain: a `FetchChainableBuilderType` built from a chain of clauses
     */
    public static func monitorList<B: FetchChainableBuilderType>(createAsynchronously: @escaping (ListMonitor<B.ObjectType>) -> Void, _ clauseChain: B) {
        
        CoreStoreDefaults.dataStack.monitorList(
            createAsynchronously: createAsynchronously,
            clauseChain.from,
            clauseChain.fetchClauses
        )
    }
    
    /**
     Using the `CoreStoreDefaults.dataStack`, creates a `ListMonitor` for a sectioned list of `DynamicObject`s that satisfy the specified fetch clauses. Multiple `ListObserver`s may then register themselves to be notified when changes are made to the list.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter sectionBy: a `SectionBy` clause indicating the keyPath for the attribute to use when sorting the list into sections.
     - parameter fetchClauses: a series of `FetchClause` instances for fetching the object list. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: a `ListMonitor` instance that monitors changes to the list
     */
    public static func monitorSectionedList<D>(_ from: From<D>, _ sectionBy: SectionBy<D>, _ fetchClauses: FetchClause...) -> ListMonitor<D> {
        
        return CoreStoreDefaults.dataStack.monitorSectionedList(from, sectionBy, fetchClauses)
    }
    
    /**
     Using the `CoreStoreDefaults.dataStack`, creates a `ListMonitor` for a sectioned list of `DynamicObject`s that satisfy the specified fetch clauses. Multiple `ListObserver`s may then register themselves to be notified when changes are made to the list.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter sectionBy: a `SectionBy` clause indicating the keyPath for the attribute to use when sorting the list into sections.
     - parameter fetchClauses: a series of `FetchClause` instances for fetching the object list. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: a `ListMonitor` instance that monitors changes to the list
     */
    public static func monitorSectionedList<D>(_ from: From<D>, _ sectionBy: SectionBy<D>, _ fetchClauses: [FetchClause]) -> ListMonitor<D> {
        
        return CoreStoreDefaults.dataStack.monitorSectionedList(from, sectionBy, fetchClauses)
    }
    
    /**
     Creates a `ListMonitor` for a sectioned list of `DynamicObject`s that satisfy the specified `SectionMonitorBuilderType` built from a chain of clauses.
     ```
     let monitor = dataStack.monitorSectionedList(
         From<MyPersonEntity>()
             .sectionBy(\.age, { "\($0!) years old" })
             .where(\.age > 18)
             .orderBy(.ascending(\.age))
     )
     ```
     - parameter clauseChain: a `SectionMonitorBuilderType` built from a chain of clauses
     - returns: a `ListMonitor` for a list of `DynamicObject`s that satisfy the specified `SectionMonitorBuilderType`
     */
    public static func monitorSectionedList<B: SectionMonitorBuilderType>(_ clauseChain: B) -> ListMonitor<B.ObjectType> {
        
        return CoreStoreDefaults.dataStack.monitorSectionedList(
            clauseChain.from,
            clauseChain.sectionBy,
            clauseChain.fetchClauses
        )
    }
    
    /**
     Using the `CoreStoreDefaults.dataStack`, asynchronously creates a `ListMonitor` for a sectioned list of `DynamicObject`s that satisfy the specified fetch clauses. Multiple `ListObserver`s may then register themselves to be notified when changes are made to the list. Since `NSFetchedResultsController` greedily locks the persistent store on initial fetch, you may prefer this method instead of the synchronous counterpart to avoid deadlocks while background updates/saves are being executed.
     
     - parameter createAsynchronously: the closure that receives the created `ListMonitor` instance
     - parameter from: a `From` clause indicating the entity type
     - parameter sectionBy: a `SectionBy` clause indicating the keyPath for the attribute to use when sorting the list into sections.
     - parameter fetchClauses: a series of `FetchClause` instances for fetching the object list. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     */
    public static func monitorSectionedList<D>(createAsynchronously: @escaping (ListMonitor<D>) -> Void, _ from: From<D>, _ sectionBy: SectionBy<D>, _ fetchClauses: FetchClause...) {
        
        CoreStoreDefaults.dataStack.monitorSectionedList(createAsynchronously: createAsynchronously, from, sectionBy, fetchClauses)
    }
    
    /**
     Using the `CoreStoreDefaults.dataStack`, asynchronously creates a `ListMonitor` for a sectioned list of `DynamicObject`s that satisfy the specified fetch clauses. Multiple `ListObserver`s may then register themselves to be notified when changes are made to the list. Since `NSFetchedResultsController` greedily locks the persistent store on initial fetch, you may prefer this method instead of the synchronous counterpart to avoid deadlocks while background updates/saves are being executed.
     
     - parameter createAsynchronously: the closure that receives the created `ListMonitor` instance
     - parameter from: a `From` clause indicating the entity type
     - parameter sectionBy: a `SectionBy` clause indicating the keyPath for the attribute to use when sorting the list into sections.
     - parameter fetchClauses: a series of `FetchClause` instances for fetching the object list. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     */
    public static func monitorSectionedList<D>(createAsynchronously: @escaping (ListMonitor<D>) -> Void, _ from: From<D>, _ sectionBy: SectionBy<D>, _ fetchClauses: [FetchClause]) {
        
        CoreStoreDefaults.dataStack.monitorSectionedList(createAsynchronously: createAsynchronously, from, sectionBy, fetchClauses)
    }
    
    /**
     Asynchronously creates a `ListMonitor` for a sectioned list of `DynamicObject`s that satisfy the specified `SectionMonitorBuilderType` built from a chain of clauses.
     ```
     dataStack.monitorSectionedList(
         createAsynchronously: { (monitor) in
             self.monitor = monitor
         },
         From<MyPersonEntity>()
             .sectionBy(\.age, { "\($0!) years old" })
             .where(\.age > 18)
             .orderBy(.ascending(\.age))
     )
     ```
     - parameter createAsynchronously: the closure that receives the created `ListMonitor` instance
     - parameter clauseChain: a `SectionMonitorBuilderType` built from a chain of clauses
     */
    public static func monitorSectionedList<B: SectionMonitorBuilderType>(createAsynchronously: @escaping (ListMonitor<B.ObjectType>) -> Void, _ clauseChain: B) {
        
        CoreStoreDefaults.dataStack.monitorSectionedList(
            createAsynchronously: createAsynchronously,
            clauseChain.from,
            clauseChain.sectionBy,
            clauseChain.fetchClauses
        )
    }
}
