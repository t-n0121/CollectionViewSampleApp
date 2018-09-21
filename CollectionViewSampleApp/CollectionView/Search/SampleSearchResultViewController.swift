
import UIKit
import RxSwift

class SampleSearchResultViewController: UIViewController {

	private var contentViewController: SampleContentsViewController!

	private let disposeBag = DisposeBag()

	static func instantiate(keyWord: String) -> SampleSearchResultViewController {
		let vc = UIStoryboard(name: "SampleSearchResult", bundle: nil).instantiateViewController(withIdentifier: "SampleSearchResultView") as! SampleSearchResultViewController

		vc.title = keyWord

		return vc
	}

    override func viewDidLoad() {
        super.viewDidLoad()        
		navigationController?.title = title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
