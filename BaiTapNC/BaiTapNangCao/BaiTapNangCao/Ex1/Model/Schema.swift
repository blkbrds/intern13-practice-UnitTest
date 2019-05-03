//
//  Model.swift
//  BaiTapNangCao
//
//  Created by MBA0144 on 5/3/19.
//  Copyright © 2019 MBA0144. All rights reserved.
//

import Foundation

final class Schema {

    var isOpen: Bool = false
    var title: String
    var id: Int

    var parent: Schema? {
        didSet {
            if let parent = parent, !parent.childs.contains(where: { $0.id == self.id }) {
                parent.childs.append(self)
            }
        }
    }
    var childs: [Schema] = [] {
        didSet {
            for child in childs {
                child.parent = self
            }
        }
    }
    var depth: Int {
        if let parent = parent {
            return parent.depth + 1
        }
        return 0
    }

    init(title: String, id: Int) {
        self.title = title
        self.id = id
    }
}
