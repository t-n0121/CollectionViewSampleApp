
/*
コンテンツを表示するCollectionView
*/

import UIKit

class SampleCollectionViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!

	let viewModel = SampleCollectionViewModel()

	let rowCount = UIDevice().userInterfaceIdiom == .pad ? 21 : 11

	static func instantiate() -> SampleCollectionViewController {
		let vc = UIStoryboard(name: "SampleCollection", bundle: nil).instantiateViewController(withIdentifier: "SampleCollectionView") as! SampleCollectionViewController
		return vc
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.register(SampleItemCollectionViewCell.nib, forCellWithReuseIdentifier: SampleItemCollectionViewCell.identifier)
		collectionView.register(SampleADCollectionViewCell.nib, forCellWithReuseIdentifier: SampleADCollectionViewCell.identifier)
        // Do any additional setup after loading the view.
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SampleCollectionViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		if indexPath.row == rowCount - 1 {
			return adCellSizeFrom(width: collectionView.bounds.size.width)
		} else {
			return itemCellSizeFrom(width: collectionView.bounds.size.width)
		}
	}

	private func itemCellSizeFrom(width: CGFloat) -> CGSize {

		let margin: CGFloat = 4
		var sidesLength: CGFloat = 0

		// 2 column
		if UIDevice().userInterfaceIdiom == .phone {
			sidesLength = (width - margin) / 2
		}

		// 4 column
		if UIDevice().userInterfaceIdiom == .pad {
			sidesLength = (width - margin * 4) / 4
		}

		return CGSize(width: sidesLength, height: sidesLength)
	}

	private func adCellSizeFrom(width: CGFloat) -> CGSize {

		// バナー広告。H:297,W:359の比率にする。
		var height = ((width - 16) * (297.0 / 359.0)).rounded(.toNearestOrAwayFromZero)

		if UIDevice().userInterfaceIdiom == .pad {
			height = 301
		}

		return CGSize(width: width, height: height)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

		let margin: CGFloat = 4

		return UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		let margin: CGFloat = 4
		return margin
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		let margin: CGFloat = 4
		return margin
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let sampleData = SampleData(indexPath.row, [])
		viewModel.cellTap(sampleData: sampleData)
	}
}

extension SampleCollectionViewController: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return rowCount
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		if indexPath.row == rowCount - 1 {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleADCollectionViewCell.identifier, for: indexPath)
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleItemCollectionViewCell.identifier, for: indexPath)
			return cell
		}
	}
}
