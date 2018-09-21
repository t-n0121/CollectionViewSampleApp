
import Foundation
import RxSwift

struct SampleDetailContentsViewModel {
	private let selectedRelatedItemEventSubject = PublishSubject<Int>()
	private let selectedHashTagEventSubject = PublishSubject<String>()

	var selectedRelatedItemEvent: Observable<Int> {
		return selectedRelatedItemEventSubject
	}

	var selectedHashTagEvent: Observable<String> {
		return selectedHashTagEventSubject
	}

	func selectedRelatedItem(id: Int) {
		selectedRelatedItemEventSubject.onNext(id)
	}

	func selectedHashTag(tag: String) {
		selectedHashTagEventSubject.onNext(tag)
	}
}
