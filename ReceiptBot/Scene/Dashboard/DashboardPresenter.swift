//
//  DashboardPresenter.swift
//  ReceiptBot
//
//  Created by Haik Ampardjian on 4/5/17.
//  Copyright (c) 2017 receiptbot. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import Charts

protocol DashboardPresenterOutput: class, Errorable, Spinnable, RefreshControlOutput {
    func updateChart(viewModel: Dashboard.PieChart.ViewModel)
}

class DashboardPresenter {
    weak var output: DashboardPresenterOutput!

    func presentPieData(response: Dashboard.PieChart.Response) {
        output.stopSpinning()
        output.refresh.endRefreshing()
        
        let dataSetWrapped = response.dataSet
        switch dataSetWrapped {
        case .value(let dataSet):
            pass(pie: dataSet)
        case .none(let message):
            output.show(type: .error(message: message))
        }
    }
    
    private func pass(pie dataSet: PieChartDataSet) {
        let data = PieChartData(dataSet: dataSet)
        let total = dataSet.values.reduce(0, { $0.0 + $0.1.y })
        
        data.setValueFormatter(PieChartFormatter(total: total))
        data.setValueTextColor(.black)
        
        let viewModel = Dashboard.PieChart.ViewModel(data: data)
        output.updateChart(viewModel: viewModel)
    }
}
