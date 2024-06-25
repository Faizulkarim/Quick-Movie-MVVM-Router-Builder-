//
//  HomeDisplayModel.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation

protocol HomePassableModel {}
// MARK: HomeDisplayModel
struct HomeDisplayModel {
    var dataSource = [HomePassableModel]()
    var nowPlayingResponseData: [Movie]? {
        didSet {
            loadCellViewModel()
        }
    }
    var trendingResponseData : [Movie]? {
        didSet {
            loadCellViewModel()
        }
    }
    
    var popularResponseData : [Movie]? {
        didSet {
            loadCellViewModel()
        }
    }
    
    var upcomingResponseData : [Movie]? {
        didSet {
            loadCellViewModel()
        }
    }
    mutating func loadCellViewModel() {
        dataSource.removeAll()
        if let data = nowPlayingResponseData {
            self.dataSource.append(nowPlayingTableCellViewModel(data: data, posterBaseUrl: Constants.posterBaseUrl))
        }
        
        if let data = trendingResponseData {
            self.dataSource.append(trendingTableCellViewModel(data: data, posterBaseUrl: Constants.posterBaseUrl, title: "Trending Movie"))
        }
        if let data = popularResponseData {
            self.dataSource.append(PopularTableCellViewModel(data: data, posterBaseUrl: Constants.posterBaseUrl, title: "Popular Movie"))
        }
        
        if let data = upcomingResponseData {
            self.dataSource.append(UpcomingTableCellViewModel(data: data, posterBaseUrl: Constants.posterBaseUrl, title: "Upcoming Movie"))
        }
    }
}

struct nowPlayingTableCellViewModel : HomePassableModel {
    var data : [Movie]?
    var posterBaseUrl: String?
}

struct trendingTableCellViewModel : HomePassableModel {
    var data : [Movie]?
    var posterBaseUrl: String?
    var title: String?
}

struct PopularTableCellViewModel : HomePassableModel {
    var data : [Movie]?
    var posterBaseUrl: String?
    var title: String?
}

struct UpcomingTableCellViewModel : HomePassableModel {
    var data : [Movie]?
    var posterBaseUrl: String?
    var title: String?
}
