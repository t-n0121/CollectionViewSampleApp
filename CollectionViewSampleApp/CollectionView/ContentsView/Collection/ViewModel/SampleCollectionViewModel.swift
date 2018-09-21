
import Foundation
import RxSwift

typealias SampleData = (
	id: Int,
	list: [Any]
)

struct SampleCollectionViewModel {
	private let cellTapEventSubject = PublishSubject<SampleData>()

	var cellTapEvent: Observable<SampleData> {
		return cellTapEventSubject
	}

	func cellTap(sampleData: SampleData) {
		cellTapEventSubject.onNext(sampleData)
	}
}
