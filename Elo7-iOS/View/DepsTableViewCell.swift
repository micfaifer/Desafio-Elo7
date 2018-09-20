//
//  DepsTableViewCell.swift
//  Elo7-iOS
//
//  Created by lugia on 19/09/18.
//  Copyright © 2018 MicFaifer. All rights reserved.
//

import UIKit

protocol UpdateCellTableHeightDelegate: class {
    func updateHeight (with height: CGFloat, at _: IndexPath)
}

class DepsTableViewCell: UITableViewCell {
    var indexPath: IndexPath?
    let depCellIdentifier = "depCell"

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var depsCollectionView: UICollectionView!
    @IBOutlet weak var depCollectionHeightConstraint: NSLayoutConstraint!

    weak var updateHeightDelegate: UpdateCellTableHeightDelegate?

    var departments: [Department] = [] {
        didSet {
            self.depsCollectionView.reloadData()

//            self.depsCollectionView.performBatchUpdates({
//                self.depsCollectionView.reloadData()
//            }) { (_) in
//                self.updateHeightDelegate?.updateHeight(with: self.depsCollectionView.contentSize.height, at: self.indexPath ?? IndexPath.init())
//            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupDepartmentCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupDepartmentCollectionView() {
        depsCollectionView.delegate = self
        depsCollectionView.dataSource = self
        depsCollectionView.isScrollEnabled = false
    }
}

extension DepsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = depsCollectionView.dequeueReusableCell(withReuseIdentifier: depCellIdentifier, for: indexPath) as! DepartmentCollectionViewCell

        cell.depIconImageView.image = UIImage(named: departments[indexPath.row].iconName)
        cell.titleLabel.text = departments[indexPath.row].name

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width/2.0 - 10

        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.depCollectionHeightConstraint.constant = self.depsCollectionView.contentSize.height
    }
}
