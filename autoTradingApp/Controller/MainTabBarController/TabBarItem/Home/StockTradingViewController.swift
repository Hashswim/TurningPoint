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

    var stock: OwnedStock? = nil
    var modelList: [AlgorithmModel] = []
    var model: AlgorithmModel?
    var selected: IndexPath?
    var isTraining: Bool = false

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
        config.titleAlignment = .center

        //toggle
        var subIitleAttr = AttributedString.init("OFF")
        subIitleAttr.font = NotoSansFont.bold(size: 22)
        config.attributedSubtitle = subIitleAttr

        btn.configuration = config

        btn.backgroundColor = MySpecialColors.traidingCircle2
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = MySpecialColors.borderGray2.cgColor
        btn.isEnabled = false
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

        let amplifyManager = AmplifyManager()
        async  {
            modelList = try await amplifyManager.postGetStockTrainingData(code: (stock?.code!)!)
            if modelList.count != 0 {
                tradingButton.isEnabled = true
                algorithmTypeLabel.attributedText = NSMutableAttributedString().regular(string: modelList.first!.algorithmType, fontSize: 13)
            }

            self.tradingStrategyTableView.reloadData()
        }

        isTraining = stock!.isTrading!
        if isTraining {
            var subIitleAttr = AttributedString.init("ON")
            subIitleAttr.font = NotoSansFont.bold(size: 22)
            tradingButton.configuration?.attributedSubtitle = subIitleAttr

            tradingButton.backgroundColor = MySpecialColors.traidingCircle
            tradingButton.layer.borderColor = MySpecialColors.borderGray3.cgColor

            tradingStrategyTableView.allowsSelection = false
            configureAnimation()
        }
    }

    //⭐️Stock object VC가 소유, 버튼 터치시 stock의 isOnTrading.toggle()
    @objc
    func changeTradingStatusAction() {
        var subIitleAttr = AttributedString()
        //toggle
        if isTraining == false {
            subIitleAttr = AttributedString.init("ON")

            tradingButton.backgroundColor = MySpecialColors.traidingCircle
            tradingButton.layer.borderColor = MySpecialColors.borderGray3.cgColor
            
            let trainingStock = TrainingStock(ownedStock: stock!, modelList: modelList, trainingModel: model)
            Stock.traiding.append(trainingStock)
            UserInfo.shared.trainingList = Stock.traiding.compactMap { $0.code }
            UserCoreDataManager.shared.update(appKey: UserInfo.shared.appKey!, trainingItems: UserInfo.shared.trainingList!)

            tradingStrategyTableView.allowsSelection = false
            configureAnimation()
        } else {
            subIitleAttr = AttributedString.init("OFF")

            tradingButton.backgroundColor = MySpecialColors.traidingCircle2
            tradingButton.layer.borderColor = MySpecialColors.borderGray2.cgColor

            tradingStrategyTableView.allowsSelection = true

//            self.stock?.isTrading = false
            Stock.traiding = Stock.traiding.filter { $0.code != self.stock?.code }
            UserInfo.shared.trainingList = Stock.traiding.compactMap { $0.code }
            UserCoreDataManager.shared.update(appKey: UserInfo.shared.appKey!, trainingItems: UserInfo.shared.trainingList!)

            self.pulseAnimationView1.layer.removeAllAnimations()
            self.pulseAnimationView2.layer.removeAllAnimations()
            self.pulseAnimationView3.layer.removeAllAnimations()

            self.pulseAnimationView1.isHidden = true
            self.pulseAnimationView2.isHidden = true
            self.pulseAnimationView3.isHidden = true
        }
        subIitleAttr.font = NotoSansFont.bold(size: 22)
        tradingButton.configuration?.attributedSubtitle = subIitleAttr

        isTraining.toggle()
    }

    func configureAnimation() {
        self.pulseAnimationView1.isHidden = false
        self.pulseAnimationView2.isHidden = false
        self.pulseAnimationView3.isHidden = false

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
        algorithmTypeLabel.attributedText = NSMutableAttributedString().regular(string: "No trained model", fontSize: 13)
        returnRateLabel.attributedText = NSMutableAttributedString().regular(string: "예상 수익률", fontSize: 13)
        algorithmTitleLabel.attributedText = NSMutableAttributedString().bold(string: "트레이딩 알고리즘", fontSize: 17)

        tradingStrategyTableView.backgroundColor = MySpecialColors.bgColor
        tradingStrategyTableView.isScrollEnabled = false
    }

    func setUpNaviBar() {
        self.title = "내 주식"

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
        return modelList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tradingStrategyTableView.dequeueReusableCell(withIdentifier: StockTradingViewTableCell.cellID, for: indexPath) as! StockTradingViewTableCell

        cell.typeLabel.attributedText = NSMutableAttributedString().bold(string: modelList[indexPath.row].algorithmType, fontSize: 15)

        if modelList[indexPath.row].predictedProfit >= 0 {
            cell.percentageLabel.attributedText = NSMutableAttributedString()
                .bold(string: "+", fontSize: 20)
                .bold(string: "\(modelList[indexPath.row].predictedProfit)", fontSize: 20)
                .bold(string: "%", fontSize: 20)
        } else {
            cell.percentageLabel.attributedText = NSMutableAttributedString()
                .bold(string: "\(modelList[indexPath.row].predictedProfit)", fontSize: 20)
                .bold(string: "%", fontSize: 20)
        }

        let backgroundView = UIView()
        cell.selectedBackgroundView = backgroundView

        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true

        if indexPath.row == 0 {
            selected = indexPath
            cell.isTouched = true
            cell.touched()
            model = modelList[indexPath.row]

            if modelList[indexPath.row].predictedProfit >= 0 {
                percentageLabel.attributedText = NSMutableAttributedString()
                    .bold(string: "+", fontSize: 28)
                    .bold(string: "\(modelList[indexPath.row].predictedProfit)", fontSize: 28)
                    .bold(string: "%", fontSize: 24)
            } else {
                percentageLabel.attributedText = NSMutableAttributedString()
                    .bold(string: "\(modelList[indexPath.row].predictedProfit)", fontSize: 28)
                    .bold(string: "%", fontSize: 24)
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? StockTradingViewTableCell else {
            return
        }
        if selected == indexPath { return }

        guard let selectedCell = tableView.cellForRow(at: selected!) as? StockTradingViewTableCell else {
            return
        }
        selected = indexPath
        model = modelList[indexPath.row]
        algorithmTypeLabel.attributedText = NSMutableAttributedString().regular(string: currentCell.typeLabel.text!, fontSize: 13)

        if modelList[indexPath.row].predictedProfit >= 0 {
            percentageLabel.attributedText = NSMutableAttributedString()
                .bold(string: "+", fontSize: 28)
                .bold(string: "\(modelList[indexPath.row].predictedProfit)", fontSize: 28)
                .bold(string: "%", fontSize: 24)
        } else {
            percentageLabel.attributedText = NSMutableAttributedString()
                .bold(string: "\(modelList[indexPath.row].predictedProfit)", fontSize: 28)
                .bold(string: "%", fontSize: 24)
        }

        currentCell.isTouched.toggle()
        currentCell.touched()

        selectedCell.isTouched.toggle()
        selectedCell.touched()
    }
}
