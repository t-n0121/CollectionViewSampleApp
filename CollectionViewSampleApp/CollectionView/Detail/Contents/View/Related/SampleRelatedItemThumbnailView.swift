
import UIKit

protocol SampleRelatedItemThumbnailViewDelegate {
	func buttonTapped(tag: Int)
}

@IBDesignable
class SampleRelatedItemThumbnailView: UIView {

	@IBOutlet private weak var imageView: UIImageView!

	@IBAction private func buttonTapped(_ sender: UIButton) {
		delegate?.buttonTapped(tag: tag)
	}

	@IBInspectable
	var image: UIImage! {
		didSet {
			guard let _image = image else { return }
			imageView.image = _image
		}
	}

	var delegate: SampleRelatedItemThumbnailViewDelegate? = nil


	public override init(frame: CGRect) {
		super.init(frame: frame)
		loadNib()
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		loadNib()
	}

	public override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		configure()
	}

	private func loadNib() {
		let bundle = Bundle(for: type(of: self))
		guard let view = UINib(nibName: "SampleRelatedItemThumbnailView", bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView else {
			return
		}
		self.addSubview(view)

		view.translatesAutoresizingMaskIntoConstraints = false
		view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

		configure()
	}

	private func configure() {
		imageView.layer.borderWidth = 1
		imageView.layer.borderColor = UIColor.lightGray.cgColor
		imageView.layer.cornerRadius = 4
	}
}
