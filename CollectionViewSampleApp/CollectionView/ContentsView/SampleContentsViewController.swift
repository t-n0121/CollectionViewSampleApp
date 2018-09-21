
import UIKit
import RxSwift

/*
一覧を表示するためのView
*/

class SampleContentsViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!

	let viewModel = SampleContentsViewModel()
	let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.register(SampleContentsCollectionViewCell.nib, forCellWithReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SampleContentsViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return collectionView.bounds.size
	}
}

extension SampleContentsViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SampleContentsCollectionViewCell
		cell.delegate = self
		return cell
	}
}

extension SampleContentsViewController: IllustrationContentsCollectionViewCellDelgete {
	func thumbnailTapped(sampleData: SampleData) {
		viewModel.selected(sampleData: sampleData)
	}
}

