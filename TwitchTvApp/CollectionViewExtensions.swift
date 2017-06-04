//
//  ReusableCell.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//
import UIKit

public protocol ReusableCell: class {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public protocol LoadNib: class {
    static var nib: UINib { get }
}

public extension LoadNib {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

public extension LoadNib where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError()
        }
        return view
    }
}

public extension UICollectionView {
    
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T: ReusableCell & LoadNib {
            self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self)
        -> T where T: ReusableCell {
            let dequeueCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
            guard let cell = dequeueCell as? T else {
                fatalError()
            }
            return cell
    }
}
