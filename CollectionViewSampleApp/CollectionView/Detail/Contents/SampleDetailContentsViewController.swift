
import UIKit
import RxSwift

class SampleDetailContentsViewController: UIViewController {
	@IBOutlet weak var contentsView: SampleContentsView!
	@IBOutlet weak var scrollView: UIScrollView!

	let viewModel = SampleDetailContentsViewModel()

	static func instantiate() -> SampleDetailContentsViewController {
		let vc = UIStoryboard(name: "SampleDetailContents", bundle: nil).instantiateViewController(withIdentifier: "SampleDetailContentsView") as! SampleDetailContentsViewController
		return vc
	}


    override func viewDidLoad() {
        super.viewDidLoad()
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
            "#Tag1",
            "#Tag2",
            "#Tag3",
            "#Tag4",
            "#Tag5",
            "#Tag6",
            "#Tag7",
            "#Tag8",
            "#Tag9",
            "#Tag10",
        ]
    }

}

extension SampleDetailContentsViewController: SampleRelatedItemViewDelegate {
	func thumbnailTapped(tag: Int) {
		viewModel.selectedRelatedItem(id: 0)
	}
}

extension SampleDetailContentsViewController: IllustrationTagContainerViewDelgate {
	func labelTapped(tag: String) {
		viewModel.selectedHashTag(tag: tag)
	}
}
