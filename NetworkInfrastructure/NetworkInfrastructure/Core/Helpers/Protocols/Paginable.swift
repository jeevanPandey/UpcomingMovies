//
//  Paginable.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

protocol Paginable {

    var currentPage: Int { get set }
    var totalPages: Int { get set }

}

extension Paginable {

    var hasMorePages: Bool {
        currentPage < totalPages
    }

    var nextPage: Int {
        hasMorePages ? currentPage + 1 : currentPage
    }

}
