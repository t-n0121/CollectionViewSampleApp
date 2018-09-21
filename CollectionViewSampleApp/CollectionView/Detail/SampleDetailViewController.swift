
import UIKit

class SampleDetailViewController: UIViewController, UIGestureRecognizerDelegate {

	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var authorIconImageView: UIImageView!
	@IBOutlet weak var authorNameLabel: UILabel!

	@IBAction func navigationBackButtonTapped(_ sender: UIButton) {
		self.navigationController?.popViewController(animated: true)
	}

	@IBAction func shareButtonTapped(_ sender: UIButton) {
		share()
	}

	private var sampleData: SampleData!

	static func instantiate(sampleData: SampleData) -> SampleDetailViewController {
		let vc = UIStoryboard(name: "SampleDetail", bundle: nil).instantiateViewController(withIdentifier: "SampleDetailView") as! SampleDetailViewController
		vc.sampleData = sampleData
		return vc
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.register(SampleDetailCollectionViewCell.nib, forCellWithReuseIdentifier: "Cell")

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

		let activityVC = UIActivityViewController(activityItems: ["Share Text", "#hashtag"], applicationActivities: nil)
		present(activityVC, animated: true, completion: nil)
	}

	func showRelatedIllust(id: Int) {
		let vc = SampleDetailViewController.instantiate(sampleData: sampleData)
		self.navigationController?.pushViewController(vc, animated: true)
	}

	func showSearchResult(tag: String) {
		// 検索結果画面呼び出し
		let vc = SampleSearchResultViewController.instantiate(keyWord: tag)
		self.navigationController?.pushViewController(vc, animated: true)
	}

}

extension SampleDetailViewController: SampleDetailCollectionViewCellDelegate {
	func relatedItemTapped(id: Int) {
		showRelatedIllust(id: id)
	}

	func hashTagButtonTapped(tag: String) {
		showSearchResult(tag: tag)
	}
}

extension SampleDetailViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return collectionView.bounds.size
	}
}

extension SampleDetailViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 100
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SampleDetailCollectionViewCell
		cell.delegate = self
		return cell
	}
}
