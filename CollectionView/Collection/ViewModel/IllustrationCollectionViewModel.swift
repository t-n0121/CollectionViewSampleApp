//
//  IllustrationCollectionViewModel.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/08/23.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import Foundation
import RxSwift

// TODO: [Any]の箇所はModel実装後に実装したモデルクラスに変更
typealias IllustData = (
	illustID: Int,
	list: [Any]
)

struct IllustrationCollectionViewModel {
	private let cellTapEventSubject = PublishSubject<IllustData>()

	var cellTapEvent: Observable<IllustData> {
		return cellTapEventSubject
	}

	func cellTap(illustData: IllustData) {
		cellTapEventSubject.onNext(illustData)
	}
}
