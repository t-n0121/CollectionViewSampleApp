//
//  IllustrationCollectionViewController.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/08/23.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit

class IllustrationCollectionViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!

	let viewModel = IllustrationCollectionViewModel()

	static func instantiate() -> IllustrationCollectionViewController {
		let vc = UIStoryboard(name: "IllustrationCollection", bundle: nil).instantiateViewController(withIdentifier: "IllustrationCollectionView") as! IllustrationCollectionViewController
		return vc
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.register(IllustrationItemCollectionViewCell.nib, forCellWithReuseIdentifier: "Cell")
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
		return cellSizeFrom(width: collectionView.bounds.size.width)
	}

	private func cellSizeFrom(width: CGFloat) -> CGSize {

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
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 100
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
		return cell
	}
}
