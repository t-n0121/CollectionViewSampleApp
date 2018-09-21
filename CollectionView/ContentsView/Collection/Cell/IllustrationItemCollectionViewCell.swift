//
//  IllustrationItemCollectionViewCell.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/08/23.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

/*
イラスト一覧ページの画像を表示するセル
*/

import UIKit

class IllustrationItemCollectionViewCell: UICollectionViewCell {

	static let nib = UINib(nibName: nibIdentifier, bundle: nil)
	static let nibIdentifier = "IllustrationItemCollectionViewCell"
	static let identifier = "Item"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
