//
//  StockTradingViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/19.
//

import UIKit

class StockTradingViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    var stock: Stock? = nil

    private let stockNameLabel: UILabel = {
        let label = UILabel()
        label.text = "VC Data sender Error"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let algorithmTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "VC Data sender Error"
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = MySpecialColors.textGray2
        label.textAlignment = .center
        label.backgroundColor = MySpecialColors.bgGray
        label.layer.borderColor = MySpecialColors.borderGray.cgColor
        label.layer.borderWidth = 1.0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10

        return label
    }()

    lazy var tradingButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .white

        var config = UIButton.Configuration.plain()
        var titleAttr = AttributedString.init("Trading")
        titleAttr.font = NotoSansFont.medium(size: 11)
        config.attributedTitle = titleAttr

        //toggle
        var subIitleAttr = AttributedString.init("OFF")
        subIitleAttr.font = NotoSansFont.bold(size: 22)
        config.attributedSubtitle = subIitleAttr

        config.titleAlignment = .center

        btn.configuration = config

        btn.backgroundColor = MySpecialColors.traidingCircle2
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = MySpecialColors.borderGray2.cgColor
        btn.addTarget(self, action: #selector(changeTradingStatusAction), for: .touchUpInside)

        return btn
    }()

    private let returnRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "수익률"
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()

    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "VC Data sender Error"
        label.textColor = .white

        return label
    }()

    private let algorithmTitleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "VC Data sender Error"
        label.textColor = .white

        return label
    }()

    let tradingStrategyTableView = StrategyTableView()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tradingButton.layer.cornerRadius = tradingButton.frame.size.width/2
        tradingButton.clipsToBounds = true

        pulseAnimationView1.layer.cornerRadius = pulseAnimationView1.layer.bounds.size.width / 2
        pulseAnimationView1.clipsToBounds = true
        pulseAnimationView2.layer.cornerRadius = pulseAnimationView2.layer.bounds.size.width / 2
        pulseAnimationView2.clipsToBounds = true
        pulseAnimationView3.layer.cornerRadius = pulseAnimationView3.layer.bounds.size.width / 2
        pulseAnimationView3.clipsToBounds = true
    }

    //Animation circular view
    private let pulseAnimationView1: UIView = {
        let view = UIView()
        view.backgroundColor = .gray

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let pulseAnimationView2: UIView = {
        let view = UIView()
        view.backgroundColor = .gray

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let pulseAnimationView3: UIView = {
        let view = UIView()
        view.backgroundColor = .gray

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MySpecialColors.bgColor
        tradingStrategyTableView.register(StockTradingViewTableCell.self, forCellReuseIdentifier: StockTradingViewTableCell.cellID)
        tradingStrategyTableView.delegate = self
        tradingStrategyTableView.dataSource = self

        setUpUI()
        setUpNaviBar()
        configureHierarchy()
        configureLayout()
    }

    //⭐️Stock object VC가 소유, 버튼 터치시 stock의 isOnTrading.toggle()
    @objc
    func changeTradingStatusAction() {
        //toggle
        var subIitleAttr = AttributedString.init("ON")
        subIitleAttr.font = NotoSansFont.bold(size: 22)
        tradingButton.configuration?.attributedSubtitle = subIitleAttr

        tradingButton.backgroundColor = MySpecialColors.traidingCircle
        tradingButton.layer.borderColor = MySpecialColors.borderGray3.cgColor

        configureAnimation()
    }

    func configureAnimation() {
        let scaleAnimaton = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimaton.fromValue = 1
        scaleAnimaton.toValue = 1.5

        let opacityAnimiation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimiation.values = [0.3, 0.7, 0]
        opacityAnimiation.keyTimes = [0, 0.3, 1]

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 9.0
        animationGroup.repeatCount = .infinity
        animationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        animationGroup.animations = [scaleAnimaton, opacityAnimiation]

        DispatchQueue.main.async {
            self.pulseAnimationView1.layer.add(animationGroup, forKey: "pulse")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.pulseAnimationView2.layer.add(animationGroup, forKey: "pulse")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.pulseAnimationView3.layer.add(animationGroup, forKey: "pulse")
        }
    }

    func setUpUI() {
        stockNameLabel.attributedText = NSMutableAttributedString().bold(string: (stock?.name)!, fontSize: 25)
        algorithmTypeLabel.attributedText = NSMutableAttributedString().regular(string: "기본형 알고리즘", fontSize: 13)
        returnRateLabel.attributedText = NSMutableAttributedString().regular(string: (stock?.isTrading)! ? "현재 수익률" : "예상 수익률", fontSize: 13)
        algorithmTitleLabel.attributedText = NSMutableAttributedString().bold(string: "트레이딩 알고리즘", fontSize: 17)

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        if stock!.priceDifference! > 0 {
            percentageLabel.attributedText = NSMutableAttributedString()
                .bold(string: "+", fontSize: 28)
                .bold(string: numberFormatter.string(from: stock!.priceDifference! as NSNumber)!, fontSize: 28)
        } else {
            percentageLabel.attributedText = NSMutableAttributedString()
                .bold(string: numberFormatter.string(from: stock!.priceDifference! as NSNumber)!, fontSize: 28)
        }

        tradingStrategyTableView.backgroundColor = MySpecialColors.bgColor
        tradingStrategyTableView.isScrollEnabled = false
    }

    func setUpNaviBar() {
        self.title = "내 주식"

//        self.navigationItem.rightBarButtonItem =
//        UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favoriteButtonPressed))
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""

        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .gray
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = MySpecialColors.bgColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: NotoSansFont.medium(size: 17)]

        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }

//    @objc
//    func favoriteButtonPressed() {
//        //toggle isFavorite property and change UIBarButtonItem Image
//    }

    func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(pulseAnimationView1)
        contentView.addSubview(pulseAnimationView2)
        contentView.addSubview(pulseAnimationView3)
        contentView.addSubview(stockNameLabel)
        contentView.addSubview(algorithmTypeLabel)
        contentView.addSubview(tradingButton)
        contentView.addSubview(returnRateLabel)
        contentView.addSubview(percentageLabel)
        contentView.addSubview(algorithmTitleLabel)
        contentView.addSubview(tradingStrategyTableView)

    }

    func configureLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        tradingStrategyTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -(self.tabBarController?.tabBar.frame.size.height ?? 40)),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),

            stockNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 64),
            stockNameLabel.widthAnchor.constraint(equalToConstant: 196),
            stockNameLabel.heightAnchor.constraint(equalToConstant: 33),
            stockNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            algorithmTypeLabel.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor, constant: 24),
            algorithmTypeLabel.widthAnchor.constraint(equalToConstant: 120),
            algorithmTypeLabel.heightAnchor.constraint(equalToConstant: 20),
            algorithmTypeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            tradingButton.topAnchor.constraint(equalTo: algorithmTypeLabel.bottomAnchor, constant: 69),
            tradingButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 108),
            tradingButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -108),
            tradingButton.heightAnchor.constraint(equalTo: tradingButton.widthAnchor),

            returnRateLabel.topAnchor.constraint(equalTo: tradingButton.bottomAnchor, constant: 34),
            returnRateLabel.widthAnchor.constraint(equalToConstant: 72),
            returnRateLabel.heightAnchor.constraint(equalToConstant: 16),
            returnRateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            percentageLabel.topAnchor.constraint(equalTo: returnRateLabel.bottomAnchor, constant: 8),
            percentageLabel.widthAnchor.constraint(equalToConstant: 100),
            percentageLabel.heightAnchor.constraint(equalToConstant: 40),
            percentageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            algorithmTitleLabel.topAnchor.constraint(equalTo: percentageLabel.bottomAnchor, constant: 72),
            algorithmTitleLabel.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            algorithmTitleLabel.widthAnchor.constraint(equalToConstant: 132),
            algorithmTitleLabel.heightAnchor.constraint(equalToConstant: 25),

            tradingStrategyTableView.topAnchor.constraint(equalTo: algorithmTitleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            tradingStrategyTableView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tradingStrategyTableView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tradingStrategyTableView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: 40),

            pulseAnimationView1.heightAnchor.constraint(equalTo: tradingButton.heightAnchor),
            pulseAnimationView1.widthAnchor.constraint(equalTo: tradingButton.widthAnchor),
            pulseAnimationView1.centerYAnchor.constraint(equalTo: tradingButton.centerYAnchor),
            pulseAnimationView1.centerXAnchor.constraint(equalTo: tradingButton.centerXAnchor),

            pulseAnimationView2.heightAnchor.constraint(equalTo: tradingButton.heightAnchor),
            pulseAnimationView2.widthAnchor.constraint(equalTo: tradingButton.widthAnchor),
            pulseAnimationView2.centerYAnchor.constraint(equalTo: tradingButton.centerYAnchor),
            pulseAnimationView2.centerXAnchor.constraint(equalTo: tradingButton.centerXAnchor),

            pulseAnimationView3.heightAnchor.constraint(equalTo: tradingButton.heightAnchor),
            pulseAnimationView3.widthAnchor.constraint(equalTo: tradingButton.widthAnchor),
            pulseAnimationView3.centerYAnchor.constraint(equalTo: tradingButton.centerYAnchor),
            pulseAnimationView3.centerXAnchor.constraint(equalTo: tradingButton.centerXAnchor),
        ])
    }

}

//⭐️트레이딩 알고리즘 모델 값을 stock 모델이 소유해야 할듯?
extension StockTradingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tradingStrategyTableView.dequeueReusableCell(withIdentifier: StockTradingViewTableCell.cellID, for: indexPath) as! StockTradingViewTableCell

        cell.typeLabel.text = PredictedAlgorithm.attack.rawValue
        cell.percentageLabel.text = "+5.1%"

        let backgroundView = UIView()
        cell.selectedBackgroundView = backgroundView

        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? StockTradingViewTableCell else {
            return
        }
        currentCell.isTouched.toggle()
        currentCell.touched()
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? StockTradingViewTableCell else {
            return
        }
        currentCell.isTouched.toggle()
        currentCell.touched()
    }
}
