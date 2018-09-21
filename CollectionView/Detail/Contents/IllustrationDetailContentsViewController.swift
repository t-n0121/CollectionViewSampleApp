//
//  IllustrationDetailContentsViewController.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/08/23.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

/*
イラスト詳細画面のメインView
このViewControllerでイラスト詳細画面を生成する
*/

import UIKit
import RxSwift

class IllustrationDetailContentsViewController: UIViewController {
	@IBOutlet weak var contentsView: IllustContentsView!
	@IBOutlet weak var scrollView: UIScrollView!

	let viewModel = IllustrationDetailContentsViewModel()

	static func instantiate() -> IllustrationDetailContentsViewController {
		let vc = UIStoryboard(name: "IllustrationDetailContents", bundle: nil).instantiateViewController(withIdentifier: "IllustrationDetailContentsView") as! IllustrationDetailContentsViewController
		return vc
	}


    override func viewDidLoad() {
        super.viewDidLoad()
		scrollView.contentInset.bottom = 80

        // Do any additional setup after loading the view.
		contentsView.relatedIllustsView.delegate = self
		contentsView.tagContainerView.delegate = self
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		contentsView.tagContainerView.configure(tags: dummyTags)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	private var dummyTags: [String] {
		return [
			"#ファンタジー",
			"#らくがき",
			"#ファンアート",
			"#魔法少女",
			"#王様ランキング",
			"#マンガハック",
			"#らくがき",
			"#ファンアート",
			"#魔法少女",
			"#王様ランキング",
		]
	}

}

extension IllustrationDetailContentsViewController: RelatedIllustrationViewDelegate {
	func thumbnailTapped(tag: Int) {
		viewModel.selectedRelatedIllust(illustID: 0)
	}
}

extension IllustrationDetailContentsViewController: IllustrationTagContainerViewDelgate {
	func labelTapped(tag: String) {
		viewModel.selectedHashTag(tag: tag)
	}
}
