//
//  IllustrationDetailViewController.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/08/23.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

/*
イラスト詳細画面のroot
ヘッダー情報と詳細画面を表示するUICollectionViewを生成するView
主にスワイプでのコンテンツの切り替えを行う
*/

import UIKit

class IllustrationDetailViewController: UIViewController, UIGestureRecognizerDelegate {

	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var authorIconImageView: UIImageView!
	@IBOutlet weak var authorNameLabel: UILabel!

	@IBAction func navigationBackButtonTapped(_ sender: UIButton) {
		self.navigationController?.popViewController(animated: true)
	}

	@IBAction func shareButtonTapped(_ sender: UIButton) {
		share()
	}
	@IBAction func giftingButtonTapped(_ sender: UIButton) {
		let giftingVC = GiftingViewController.instantiate(type: .illustration, targetID: 0, authorID: 0)
		present(giftingVC, animated: true, completion: nil)
	}

	private var illustData: IllustData!

	static func instantiate(illustData: IllustData) -> IllustrationDetailViewController {
		let vc = UIStoryboard(name: "IllustrationDetail", bundle: nil).instantiateViewController(withIdentifier: "IllustrationDetailView") as! IllustrationDetailViewController
		vc.illustData = illustData
		return vc
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.register(IllustrationDetailCollectionViewCell.nib, forCellWithReuseIdentifier: "Cell")

		self.navigationController?.interactivePopGestureRecognizer?.delegate = self
		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

		let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		navigationItem.backBarButtonItem = backButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.isNavigationBarHidden = true
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.navigationController?.isNavigationBarHidden = false
	}
    

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		// エッジスワイプの時は横スクロールを無視する
		if gestureRecognizer is UIScreenEdgePanGestureRecognizer {
			return true
		}

		return false
	}

	private func share() {

		// TODO: implements firebase event track!

		/*
		share text to
		作者名のイラスト「タイトル」がいいね！ #マンガハック
		https://mangahack.com/illusts/〇〇〇
		*/

		let authorName = "坂野克紀"
		let illustTitle = "ゲスメイジさん暑中見舞い"
		let illustID = 1

		let urlStr = String(format: Mangahack.illustPageURL, arguments: [illustID])
		let url = URL(string: urlStr)!
		let activityVC = UIActivityViewController(activityItems: ["\(authorName)のイラスト「\(illustTitle)」がいいね！", "#マンガハック", url], applicationActivities: nil)
		present(activityVC, animated: true, completion: nil)
	}

	func showRelatedIllust(illustID: Int) {
		let vc = IllustrationDetailViewController.instantiate(illustData: illustData)
		self.navigationController?.pushViewController(vc, animated: true)
	}

	func showSearchResult(tag: String) {
		// 検索結果画面呼び出し
		let vc = IllustrationSearchResultViewController.instantiate(keyWord: tag)
		self.navigationController?.pushViewController(vc, animated: true)
	}

}

extension IllustrationDetailViewController: IllustrationDetailCollectionViewCellDelegate {
	func relatedIllustTapped(illustID: Int) {
		showRelatedIllust(illustID: illustID)
	}

	func hashTagButtonTapped(tag: String) {
		showSearchResult(tag: tag)
	}
}

extension IllustrationDetailViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return collectionView.bounds.size
	}
}

extension IllustrationDetailViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! IllustrationDetailCollectionViewCell
		cell.delegate = self
		return cell
	}
}
