//
//  LoadingView.swift
//  Weather SDK
//
//  Created by Lester Batres on 22/10/24.
//

import UIKit

protocol LoadingViewPresentable {

    func showLoading()
    func hideLoading()
}

extension LoadingViewPresentable where Self: UIViewController {

    func showLoading() {
        let topFrame = self.view.bounds

        loadingView = LoadingView(frame: topFrame)

        self.view.addSubview(loadingView)
    }

    func hideLoading() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
}


private var loadingView: LoadingView!

final class LoadingView: UIView {

    private var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.color = .white
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        addIndicatorView()
        activityIndicator.startAnimating()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private methods

    private func addIndicatorView() {
        activityIndicator = UIActivityIndicatorView(style: .large)

        addSubview(activityIndicator)
        
        let size = bounds.width / 2
        let yPosition = (frame.height / 2)
        
        activityIndicator.frame = CGRect(x: size, y: yPosition, width: 20.0, height: 20.0)
    }
}

