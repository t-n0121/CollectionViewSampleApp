//
//  IllustrationContentsCollectionViewCell.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/08/23.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
/*
イラスト一覧画面ページング用のセル
*/

protocol IllustrationContentsCollectionViewCellDelgete {
	func thumbnailTapped(illustData: IllustData)
}

class IllustrationContentsCollectionViewCell: UICollectionViewCell {

	static let nib = UINib(nibName: identifier, bundle: nil)
	static let identifier = "IllustrationContentsCollectionViewCell"

	let disposeBag = DisposeBag()

	var vc: IllustrationCollectionViewController!
	var delegate: IllustrationContentsCollectionViewCellDelgete? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

		vc = IllustrationCollectionViewController.instantiate()
		observeTapEvent(tapEvent: vc.viewModel.cellTapEvent)
		contentView.addSubview(vc.view)

		guard let view = vc.view else { return }
		view.translatesAutoresizingMaskIntoConstraints = false
		view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

	private func observeTapEvent(tapEvent: Observable<IllustData>) {
		tapEvent.subscribe(onNext: { (illustData) in
			self.delegate?.thumbnailTapped(illustData: illustData)
		}).disposed(by: disposeBag)
	}
}
