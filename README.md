# Turning Point

Turning Point is an ios stock advisor app that uses eBest investment securities open API to inform transaction signals and provide stock trading services through AI investment strategies for each stock.

<img src="https://github.com/Hashswim/TurningPoint/assets/57447946/56b59642-717e-480e-b914-9826edae0fb8" width="40%" height="40%">
<img src="https://github.com/Hashswim/TurningPoint/assets/57447946/1806902e-b124-4389-9c98-369ce7390f3a" width="40%" height="40%" style="float: ">

## Environment
![](https://img.shields.io/badge/Interface-UIKit-green.svg) ![](https://img.shields.io/badge/Architecture-MVC-yellow.svg) ![](https://img.shields.io/badge/Lisence-Burning_Reach-red.svg) ![](https://img.shields.io/badge/Database-MySQL-brown.svg)
[![swift](https://img.shields.io/badge/swift-5.6-orange)]() [![swift](https://img.shields.io/badge/python-5.0-orange)]()
[![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]()
[![xcode](https://img.shields.io/badge/IOS-15.0+-skyblue)]()


## 🗒︎ Table of Contents
1. [What can you do](#--what-can-you-do)
2. [Features](#--features)
3. [Technical Background](#--technical-background)
4. [Structrues](#--structrues)
5. [Architecture](#--architecture)

## 🎯What can you do
 - You can check the logo of the stock using the backend stock home page table
 - You can register your shares in the AI model to receive transaction signals through individual prediction models
 - You can check the charts and details of the stocks you have or the training model, and you can buy or sell them
 - You can check the transaction information (date, type, price, etc.) sold through the advisor by stock
 
<details>
    <summary> Guide Images </summary>
<img src="https://github.com/Hashswim/TurningPoint/assets/57447946/dffb2d7b-33f5-462f-b844-69e329ebe8d3" width="23%" height="23%">
<img src="https://github.com/Hashswim/TurningPoint/assets/57447946/9651e9e2-72eb-4d36-bd0d-30f3c82ea3d0" width="23%" height="23%">
<img src="https://github.com/Hashswim/TurningPoint/assets/57447946/87a7e704-df83-4243-a246-9107da675160" width="23%" height="23%">
<img src="https://github.com/Hashswim/TurningPoint/assets/57447946/2b08f6f7-ace7-47a4-96a4-4512e37daebd" width="23%" height="23%">
</details>


## 🖥︎Features

|login|Main Home Tab|Search Stocks|
|------|------|------|
|![](https://github.com/Hashswim/TurningPoint/assets/57447946/f829d0f5-7638-411c-b79c-77700965a4a4)|![](https://github.com/Hashswim/TurningPoint/assets/57447946/c2252796-c7ac-4a29-bcfa-10966cc919d9)|![](https://github.com/Hashswim/TurningPoint/assets/57447946/3aae16ed-9b51-478a-a3cb-5864716c9bba)|
|Trading Tab|My page Tab|Stock Detail View|
|![](https://github.com/Hashswim/TurningPoint/assets/57447946/054dc5ff-f1f2-4765-a510-cfdb1ad687a6)|![](https://github.com/Hashswim/TurningPoint/assets/57447946/c708b0f4-4314-43e8-b2ad-dc4a6050b933)|![](https://github.com/Hashswim/TurningPoint/assets/57447946/ef35cb54-f45a-47cf-b8b7-a72d5d7bae55)|

## 🛠Technical Background
 - Serverless AI model communication using Amplify rest api
 - Load application restart data by storing preferred items, profile images, access tokens, etc. using core data
 - Stock information and trading communications using eBest open api
 - Modularization reduces code reuse by managing duplicate view type files
 - Use inheritance and protocols to manage stock models and manage dependencies
 - Use modern collection view to configure collection view; efficiently configure data sources and cells; smoother and more efficient configuration
 - Use Lightweight Charts and Charts libraries to display chart data for high visibility

## 🏗Structrues

<details>
    <summary>Project Structure</summary>
    
    
	├── Podfile
	├── Podfile.lock
	├── Pods
	│   ├── Alamofire
	│   ├── Charts
	│   ├── DropDown
	│   ├── Headers
	│   ├── LightweightCharts
	│   ├── SwiftAlgorithms
	│   ├── SwiftyJSON
	│   └── TinyConstraints
	│
	├── amplify
	│   ├── #current-cloud-backend
	│   │   ├── amplify-meta.json
	│   │   ├── api
	│   │   │   └── apiTP
	│   │   ├── auth
	│   │   │   └── turningpoint
	│   │   └── function
	│   │       └── turningpointd4c149cb
	│   │           └── src
	│   │               └── index.py #
	│   └── backend
	│ 
	└── autoTradingApp
	    ├── CoreData
	    │   ├── TransactionCoreDataManager.swift
	    │   ├── UserCoreData.xcdatamodeld
	    │   │   └── UserCoreData.xcdatamodel
	    │   │       └── contents
	    │   └── UserCoreDataManager.swift
	    │
	    ├── Controller
	    │   ├── Initial
	    │   │   └── InitialViewController.swift
	    │   ├── Login
	    │   │   └── LoginViewController.swift
	    │   ├── MainTabBarController
	    │   │   ├── MainTabBarControllerViewController.swift
	    │   │   └── TabBarItem
	    │   │       ├── Home
	    │   │       │   ├── DetailViewController.swift
	    │   │       │   ├── MainHomeTabController.swift
	    │   │       │   ├── StockTradingViewController.swift
	    │   │       │   └── StrategyTableView.swift
	    │   │       ├── MyPage
	    │   │       │   └── MyPageViewController.swift
	    │   │       ├── Search
	    │   │       │   ├── SearchViewController.swift
	    │   │       │   └── TradableViewController.swift
	    │   │       └── Trading
	    │   │           └── TradingViewController.swift
	    │   └── SignUp
	    │       ├── SignUpGuideViewController.swift
	    │       ├── SignUpIsUserViewController.swift
	    │       └── SignUpTOSViewController.swift
	    │
	    ├── Model
	    │   ├── AlgorithmModel.swift
	    │   ├── Network
	    │   │   ├── AmplifyManager.swift
	    │   │   ├── CellDataModel.swift
	    │   │   ├── JSONParser.swift
	    │   │   ├── NetworkManager.swift
	    │   │   ├── PredictedRawServerResponse.swift
	    │   │   └── RequestType.swift
	    │   ├── Stock.swift
	    │   ├── TradingTransaction.swift
	    │   └── UserInfo.swift
	    │ 
	    │
	    ├── View
	    │   ├── Initial
	    │   │   └── GuideCollectionViewCell.swift
	    │   ├── Login
	    │   │   ├── CustomTextField.swift
	    │   │   ├── LoginView.swift
	    │   │   └── temp.swift
	    │   ├── MenuTab
	    │   │   ├── ChartView2.swift
	    │   │   ├── MainTabView
	    │   │   │   ├── AdditionalTradingCellView.swift
	    │   │   │   ├── DropDownView.swift
	    │   │   │   ├── StcokListCellCollectionViewCell.swift
	    │   │   │   ├── StockInfoView.swift
	    │   │   │   ├── StockTradingViewTableCell.swift
	    │   │   │   ├── TradingSegmentedControl.swift
	    │   │   │   └── mainTabSegmentedControl.swift
	    │   │   ├── MyPage
	    │   │   │   └── ExpandableTableViewCell.swift
	    │   │   ├── SearchView
	    │   │   │   ├── CustomStepper.swift
	    │   │   │   ├── SearchViewCustomCell.swift
	    │   │   │   └── TransactionView.swift
	    │   │   └── TradingView
	    │   │       ├── HeaderCell.swift
	    │   │       ├── HeaderView.swift
	    │   │       ├── TradingCell.swift
	    │   │       └── TransactionButton.swift
	    │   └── SignUp
	    │       ├── SignUpGuideView.swift
	    │       ├── SignUpIsUserView.swift
	    │       └── SignUpTOSView.swift
	    │
	    └── Utility
	        ├── Array+.swift
	        ├── Font
	        │   ├── NotoSansFont.swift
	        │   ├── NotoSansKR-Bold.otf
	        │   └── NotoSansKR-Regular.otf
	        ├── GuideConstant.swift
	        ├── NSMutableAttributedString.swift
	        ├── SwiftyJSON+.swift
	        ├── UIColor+.swift
	        └── UIImage+.swift
	
</details>

## 🗺Architecture
<details>
    <summary> Class Diagram </summary>
    <img src="https://github.com/Hashswim/TurningPoint/assets/57447946/65eaf8f8-1798-471b-8f93-a4ab5ffd2ff2" width="100%" height="90%">
</details>
<details>
    <summary> Flow Chart </summary>
    <img src="https://github.com/Hashswim/TurningPoint/assets/57447946/d55e2556-5fcc-4979-bd6b-dd98433ea213" width="100%" height="90%">
</details>
<details>
    <summary> Sequence Diagram </summary>
    <img src="https://github.com/Hashswim/TurningPoint/assets/57447946/c2e482c1-f166-485c-a5fd-02e407a4edaa" width="100%" height="90%">
</details>




