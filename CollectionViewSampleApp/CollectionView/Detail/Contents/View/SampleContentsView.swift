
import UIKit

@IBDesignable
class SampleContentsView: UIView {

	
	@IBOutlet weak var imageView: SampleItemImageView!
	@IBOutlet weak var descriptionView: SampleItemDescriptionView!
	@IBOutlet weak var tagContainerView: SampleItemTagContainerView!
	@IBOutlet weak var relatedIllustsView: SampleRelatedItemView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		loadNib()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		loadNib()
	}

	private func loadNib() {
		let bundle = Bundle(for: type(of: self))
		guard let view = UINib(nibName: "SampleContentsView", bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView else {
			return
		}
		self.addSubview(view)

		view.translatesAutoresizingMaskIntoConstraints = false
		view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

	}
	
}
