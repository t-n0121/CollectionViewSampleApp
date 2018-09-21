
import UIKit
import RxSwift
import RxCocoa
/*
ページング用セル
*/

protocol IllustrationContentsCollectionViewCellDelgete {
	func thumbnailTapped(sampleData: SampleData)
}

class SampleContentsCollectionViewCell: UICollectionViewCell {

	static let nib = UINib(nibName: identifier, bundle: nil)
	static let identifier = "SampleContentsCollectionViewCell"

	let disposeBag = DisposeBag()

	var vc: SampleCollectionViewController!
	var delegate: IllustrationContentsCollectionViewCellDelgete? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

		vc = SampleCollectionViewController.instantiate()
		observeTapEvent(tapEvent: vc.viewModel.cellTapEvent)
		contentView.addSubview(vc.view)

		guard let view = vc.view else { return }
		view.translatesAutoresizingMaskIntoConstraints = false
		view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

	private func observeTapEvent(tapEvent: Observable<SampleData>) {
		tapEvent.subscribe(onNext: { (sampleData) in
			self.delegate?.thumbnailTapped(sampleData: sampleData)
		}).disposed(by: disposeBag)
	}
}
