
import UIKit
import RxSwift

class SampleCollectionRootViewController: UIViewController {
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var searchBar: SearchBar!

	@IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        let searchView = SearchViewController(title: "検索", placeholder: "キーワードを入力")
		present(searchView, animated: false, completion: nil)

		searchView.viewModel.searchExecute
			.subscribeOn(MainScheduler.instance)
			.subscribe { (keyWord) in
				// 検索結果画面呼び出し
				guard let keyWord = keyWord.element else { return }
				let vc = SampleSearchResultViewController.instantiate(keyWord: keyWord)
				self.navigationController?.pushViewController(vc, animated: true)
			}.disposed(by: disposeBag)
	}
	private let disposeBag = DisposeBag()
	private var contentViewController: SampleContentsViewController!

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
		if let vc = segue.destination as? SampleContentsViewController {
			contentViewController = vc
			observeTapEvent(tapEvent: vc.viewModel.selectedEvent)
		}
    }

	private func observeTapEvent(tapEvent: Observable<SampleData>) {
		tapEvent.subscribe(onNext: { [weak self] (sampleData) in
			self?.showIllustDetailView(sampleData: sampleData)
		}).disposed(by: disposeBag)
	}

	private func showIllustDetailView(sampleData: SampleData) {
		let detailVC = SampleDetailViewController.instantiate(sampleData: sampleData)
		detailVC.hidesBottomBarWhenPushed = true

		self.navigationController?.pushViewController(detailVC, animated: true)
	}
}
