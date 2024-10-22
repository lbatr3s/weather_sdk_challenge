//
//  WeatherForecastViewController.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import UIKit
import Combine

protocol WeatherForecastViewInput: AnyObject, LoadingViewPresentable {
    
    func setupInitialState(viewModel: CurrentWeatherViewModel)
    func updateScreenWithHourlyData(data: [HourlyWeatherViewModel])
    func showLoading()
    func hideLoading()
    func endRefreshing()
    func moduleInput() -> WeatherForecastModuleInput
}

protocol WeatherForecastViewOutput {
    
    func viewIsReady()
    func didTapBackButton()
    func startRefreshing()
}

public class WeatherForecastViewController: UIViewController {
    
    private var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 60
            tableView.rowHeight = UITableView.automaticDimension
            tableView.refreshControl = refreshControl
        }
    }
    
    @IBOutlet weak var forecastHeaderView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .textRegular
            titleLabel.textColor = .textPrimary
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.font = .h1
            temperatureLabel.textColor = .textPrimary
            temperatureLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel! {
        didSet {
            weatherDescriptionLabel.font = .textRegular
            weatherDescriptionLabel.textColor = .textPrimary
            weatherDescriptionLabel.textAlignment = .center
            weatherDescriptionLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = .label
            timeLabel.textColor = .textSecondary
            timeLabel.textAlignment = .center
        }
    }
    
    private var hourlyData: [HourlyWeatherViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return control
    }()
    
    static let identifier = "WeatherForecastViewController"
    
    var output: WeatherForecastViewOutput!

    public override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem(title: "Back", image: UIImage(systemName: "chevron.left"), target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem = backButton
        
        title = "24H Forecast"
        
        output.viewIsReady()
    }
    
    @objc private func didTapBackButton() {
        output.didTapBackButton()
    }
    
    @objc private func didPullToRefresh() {
        output.startRefreshing()
    }
}


// MARK: UITableview dataSource and delegate methods

extension WeatherForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hourlyData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherTableViewCell.identifier, for: indexPath) as! HourlyWeatherTableViewCell
        let data = hourlyData[indexPath.row]
        
        cell.configure(viewModel: data)
        
        return cell
    }
}

// MARK: WeatherForecastViewInput methods

extension WeatherForecastViewController: WeatherForecastViewInput {
    
    func setupInitialState(viewModel: CurrentWeatherViewModel) {
        titleLabel.text = viewModel.title
        temperatureLabel.text = viewModel.temperature
        weatherDescriptionLabel.text = viewModel.weatherDescription
        timeLabel.text = viewModel.time
        
        tableView.tableHeaderView = forecastHeaderView
        tableView.fitSizeForTableHeaderView()
    }
    
    func updateScreenWithHourlyData(data: [HourlyWeatherViewModel]) {
        hourlyData = data
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func moduleInput() -> WeatherForecastModuleInput {
        output as! WeatherForecastModuleInput
    }
}
