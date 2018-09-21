//
//  IllustrationContentsViewController.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/08/22.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit
import RxSwift

/*
イラスト一覧を表示するためのView
とりあえずは1画面だが今後カテゴライズする可能性があるのでUICollectionViewで
ページングできるようにしてある
*/

class IllustrationContentsViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!

	let viewModel = IllustrationContentsViewModel()
	let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.register(IllustrationContentsCollectionViewCell.nib, forCellWithReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension IllustrationContentsViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return collectionView.bounds.size
	}
}

extension IllustrationContentsViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! IllustrationContentsCollectionViewCell
		cell.delegate = self
		return cell
	}
}

extension IllustrationContentsViewController: IllustrationContentsCollectionViewCellDelgete {
	func thumbnailTapped(illustData: IllustData) {
		viewModel.selected(illustData: illustData)
	}
}

