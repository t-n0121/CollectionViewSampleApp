//
//  IllustrationSearchResultViewController.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/09/07.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit
import RxSwift

class IllustrationSearchResultViewController: UIViewController {

	private var contentViewController: IllustrationContentsViewController!

	private let disposeBag = DisposeBag()

	static func instantiate(keyWord: String) -> IllustrationSearchResultViewController {
		let vc = UIStoryboard(name: "IllustrationSearchResult", bundle: nil).instantiateViewController(withIdentifier: "IllustrationSearchResultView") as! IllustrationSearchResultViewController

		vc.title = keyWord

		return vc
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		navigationController?.title = title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
