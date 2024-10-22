//
//  UITableView+Extensions.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import UIKit

extension UITableView {
    
    /**
     This function lets you autolayout TableHeaderView.
     
     */
    func fitSizeForTableHeaderView() {
        guard let headerView = tableHeaderView else {
            return
        }

        var headerViewFrame = headerView.frame
        headerViewFrame.size = sizeForTableHeaderFooterView(view: headerView)
        headerView.frame = headerViewFrame

        tableHeaderView = headerView
    }


    // MARK: - Private Methods

    private func sizeForTableHeaderFooterView(view: UIView) -> CGSize {
        let desiredSize = CGSize(width: view.frame.size.width, height: 0)
        let headerSize = view.systemLayoutSizeFitting(desiredSize,
                                                      withHorizontalFittingPriority: .required,
                                                      verticalFittingPriority: .fittingSizeLevel)

        return headerSize
    }
}
