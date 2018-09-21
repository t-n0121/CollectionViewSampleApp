//
//  IllustrationViewController.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/08/22.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

/*
イラストタブのroot
*/

import UIKit
import RxSwift

class IllustrationViewController: UIViewController {
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var searchBar: MHSearchBar!

	@IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
		let searchView = MHSearchViewController(title: "イラストを探す")
		present(searchView, animated: false, completion: nil)

		searchView.viewModel.searchExecute
			.subscribeOn(MainScheduler.instance)
			.subscribe { (keyWord) in
				// 検索結果画面呼び出し
				guard let keyWord = keyWord.element else { return }
				let vc = IllustrationSearchResultViewController.instantiate(keyWord: keyWord)
				self.navigationController?.pushViewController(vc, animated: true)
			}.disposed(by: disposeBag)
	}
	private let disposeBag = DisposeBag()
	private var contentViewController: IllustrationContentsViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

		let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		navigationItem.backBarButtonItem = backButtonItem

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		if let vc = segue.destination as? IllustrationContentsViewController {
			contentViewController = vc
			observeTapEvent(tapEvent: vc.viewModel.selectedEvent)
		}
    }

	private func observeTapEvent(tapEvent: Observable<IllustData>) {
		tapEvent.subscribe(onNext: { [weak self] (illustData) in
			self?.showIllustDetailView(illustData: illustData)
		}).disposed(by: disposeBag)
	}

	private func showIllustDetailView(illustData: IllustData) {
		outputDebugLog("IllustrationViewController illustID: \(illustData.illustID)")
		let detailVC = IllustrationDetailViewController.instantiate(illustData: illustData)
		detailVC.hidesBottomBarWhenPushed = true

		self.navigationController?.pushViewController(detailVC, animated: true)
	}
}
