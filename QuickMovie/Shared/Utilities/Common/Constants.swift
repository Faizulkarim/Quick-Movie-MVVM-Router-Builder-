//
//  Constants.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import UIKit


struct Constants {
    static let containerHeight: CGFloat = UIScreen.main.bounds.size.height - UIViewController.statusBarHeight
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let posterBaseUrl = "https://image.tmdb.org/t/p/w500"
    static let authToken = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNDg4YzYyMmUyMmFiMjU5ZDA0ZDUzYjk2Y2YyMDBlNSIsInN1YiI6IjYyMzYzYTkxMDc1Mjg4MDA3MmY1M2RlNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LEXEIbDvNMFXwIC--m9IvLSW7Kwrn08FlSMgzRIO2Zo"]
}
