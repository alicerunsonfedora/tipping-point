//
//  UITableViewCell+Registration.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/30/22.
//

import UIKit

extension UITableViewCell {
    /// An identifier that can be used for cell reuse.
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableView {
    /// Registers a cell based on its class type.
    /// - Parameter cellType: The `UITableViewCell` class that the table will register a cell with.
    func register<Cell: UITableViewCell>(_: Cell.Type) {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }

    /// Dequeues a cell for reuse based on class type at a specified index path.
    /// - Parameter cellType: The class type of the cell to dequeue.
    /// - Parameter indexPath: The index path of the cell in the table's data source.
    /// - Returns: Returns the cell at the specified index, or `nil` if no cell was found or the cell isn't of the
    /// specified class type.
    func dequeueReusableCell<Cell: UITableViewCell>(_: Cell.Type, for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell
    }
}
