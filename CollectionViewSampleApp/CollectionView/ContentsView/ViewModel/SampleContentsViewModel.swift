
import Foundation
import RxSwift

struct SampleContentsViewModel {
	private let selectedEventSubject = PublishSubject<SampleData>()

	var selectedEvent: Observable<SampleData> {
		return selectedEventSubject
	}

	func selected(sampleData: SampleData) {
		selectedEventSubject.onNext(sampleData)
	}
}
