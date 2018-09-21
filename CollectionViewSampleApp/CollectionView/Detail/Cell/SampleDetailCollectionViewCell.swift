
import UIKit
import RxSwift

protocol SampleDetailCollectionViewCellDelegate {
	func relatedItemTapped(id: Int)
	func hashTagButtonTapped(tag: String)
}

class SampleDetailCollectionViewCell: UICollectionViewCell {

	static let nib = UINib(nibName: identifier, bundle: nil)
	static let identifier = "SampleDetailCollectionViewCell"

	var vc: SampleDetailContentsViewController!
	var delegate: SampleDetailCollectionViewCellDelegate? = nil

	private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		vc = SampleDetailContentsViewController.instantiate()

		contentView.addSubview(vc.view)

		guard let view = vc.view else { return }
		view.translatesAutoresizingMaskIntoConstraints = false
		view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

		observeViewModel(viewModel: vc.viewModel)
    }

	private func observeViewModel(viewModel: SampleDetailContentsViewModel) {
		viewModel.selectedRelatedItemEvent.subscribe(onNext: { (id) in
			self.delegate?.relatedItemTapped(id: id)
		}).disposed(by: disposeBag)

		viewModel.selectedHashTagEvent.subscribe(onNext: { (tag) in
			self.delegate?.hashTagButtonTapped(tag: tag)
		}).disposed(by: disposeBag)
	}
}
