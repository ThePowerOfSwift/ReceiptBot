//
//  ExpensesConfigurator.swift
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
// MARK: - Connect View, Interactor, and Presenter

extension ExpensesViewController: ExpensesPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}

extension ExpensesInteractor: ExpensesViewControllerOutput {
}

extension ExpensesPresenter: ExpensesInteractorOutput {
}

class ExpensesConfigurator {
    // MARK: - Object lifecycle

    static let sharedInstance = ExpensesConfigurator()

    private init() {}

    // MARK: - Configuration

    func configure(viewController: ExpensesViewController) {
        let router = ExpensesRouter()
        router.viewController = viewController

        let presenter = ExpensesPresenter()
        presenter.output = viewController

        let interactor = ExpensesInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
    
    func setup(theChart chart: LineChartView!) {
        chart.chartDescription?.enabled = false
        chart.dragEnabled = true
        chart.setScaleEnabled(true)
        chart.pinchZoomEnabled = false
        chart.drawGridBackgroundEnabled = false
        chart.highlightPerDragEnabled = true
        
        chart.backgroundColor = .white /// TODO: change to proper background color
        
        chart.legend.enabled = false
        
        let xAxis = chart.xAxis
        xAxis.labelPosition = .bottom
        /// TODO: setup font
        xAxis.labelTextColor = .black
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = false
        xAxis.granularity = 60 * 60 * 24 * 31 /// Month
        xAxis.valueFormatter = LineXAxeFormatter()
        
        setup(sideAxe: chart.leftAxis)
        setup(sideAxe: chart.rightAxis)
    }
    
    private func setup(sideAxe axe: YAxis) {
        axe.labelPosition = .outsideChart
        axe.labelFont = UIFont.systemFont(ofSize: 4.0)
        axe.labelTextColor = .black
        axe.drawAxisLineEnabled = false
        axe.drawGridLinesEnabled = false
        axe.centerAxisLabelsEnabled = false
        axe.granularity = 100_000_000
        axe.axisMinimum = 0        
    }
}
