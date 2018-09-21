//
//  IllustrationDetailCollectionViewCell.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/08/23.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit
import RxSwift

protocol IllustrationDetailCollectionViewCellDelegate {
	func relatedIllustTapped(illustID: Int)
	func hashTagButtonTapped(tag: String)
}

class IllustrationDetailCollectionViewCell: UICollectionViewCell {

	static let nib = UINib(nibName: identifier, bundle: nil)
	static let identifier = "IllustrationDetailCollectionViewCell"

	var vc: IllustrationDetailContentsViewController!
	var delegate: IllustrationDetailCollectionViewCellDelegate? = nil

	private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		vc = IllustrationDetailContentsViewController.instantiate()

		contentView.addSubview(vc.view)

		guard let view = vc.view else { return }
		view.translatesAutoresizingMaskIntoConstraints = false
		view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

		observeViewModel(viewModel: vc.viewModel)
    }

	private func observeViewModel(viewModel: IllustrationDetailContentsViewModel) {
		viewModel.selectedRelatedIllustEvent.subscribe(onNext: { (illustID) in
			self.delegate?.relatedIllustTapped(illustID: illustID)
		}).disposed(by: disposeBag)

		viewModel.selectedHashTagEvent.subscribe(onNext: { (tag) in
			self.delegate?.hashTagButtonTapped(tag: tag)
		}).disposed(by: disposeBag)
	}
}
