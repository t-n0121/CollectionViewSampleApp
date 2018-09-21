//
//  IllustrationCollectionViewController.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/08/23.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

/*
イラスト一覧画面のコンテンツを表示するView
このViewControllerが一覧画像を表示させるページになっている
*/

import UIKit

class IllustrationCollectionViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!

	let viewModel = IllustrationCollectionViewModel()

	let rowCount = UIDevice().userInterfaceIdiom == .pad ? 21 : 11

	static func instantiate() -> IllustrationCollectionViewController {
		let vc = UIStoryboard(name: "IllustrationCollection", bundle: nil).instantiateViewController(withIdentifier: "IllustrationCollectionView") as! IllustrationCollectionViewController
		return vc
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.register(IllustrationItemCollectionViewCell.nib, forCellWithReuseIdentifier: IllustrationItemCollectionViewCell.identifier)
		collectionView.register(IllustrationADCollectionViewCell.nib, forCellWithReuseIdentifier: IllustrationADCollectionViewCell.identifier)
        // Do any additional setup after loading the view.
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension IllustrationCollectionViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		if indexPath.row == rowCount - 1 {
			return adCellSizeFrom(width: collectionView.bounds.size.width)
		} else {
			return itemCellSizeFrom(width: collectionView.bounds.size.width)
		}
	}

	private func itemCellSizeFrom(width: CGFloat) -> CGSize {

		let margin: CGFloat = 4
		var sidesLength: CGFloat = 0

		// 2 column
		if UIDevice().userInterfaceIdiom == .phone {
			sidesLength = (width - margin) / 2
		}

		// 4 column
		if UIDevice().userInterfaceIdiom == .pad {
			sidesLength = (width - margin * 4) / 4
		}

		return CGSize(width: sidesLength, height: sidesLength)
	}

	private func adCellSizeFrom(width: CGFloat) -> CGSize {

		// バナー広告。H:297,W:359の比率にする。
		var height = ((width - 16) * (297.0 / 359.0)).rounded(.toNearestOrAwayFromZero)

		if UIDevice().userInterfaceIdiom == .pad {
			height = 301
		}

		return CGSize(width: width, height: height)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

		let margin: CGFloat = 4

		return UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		let margin: CGFloat = 4
		return margin
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		let margin: CGFloat = 4
		return margin
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let illustData = IllustData(indexPath.row, [])
		viewModel.cellTap(illustData: illustData)
	}
}

extension IllustrationCollectionViewController: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return rowCount
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		if indexPath.row == rowCount - 1 {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IllustrationADCollectionViewCell.identifier, for: indexPath)
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IllustrationItemCollectionViewCell.identifier, for: indexPath)
			return cell
		}
	}
}
