//
//  MainViewController.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 11/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController
import SnapKit
import Moya

final class MainViewController: BaseViewController, BinderViewType {
    
    // MARK: ViewMdoel Configure
    
    typealias ViewModel = MainViewModel
    
    var viewModel: MainViewModel!
    var disposedBag: DisposeBag = DisposeBag()
    
    // MARK: UI Properties
    
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    lazy var  collectView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .white
        view.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        view.keyboardDismissMode = .onDrag
        
        //cell
        //view.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
        
        //refresh
        //view.refreshControl = UIRefreshControl()
        
        
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력해 주세요"
        view.searchBarStyle = .prominent
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        return view
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backViewTapped(_:))))
        return view
    }()
    
    // MARK: Initializing
    
    init(viewModel: MainViewModel) {
        defer {
            self.viewModel = viewModel
            self.uiEventBinding()
            self.uiStateBinding()
        }
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func configureUI() {
        self.navigationSetting()
        self.view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        [backView, searchBar, collectView].forEach {
            self.view.addSubview($0)
        }
        
        self.view.bringSubviewToFront(backView)
        self.backView.snp.makeConstraints {
            $0.top.equalTo(self.collectView.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        
        self.searchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        self.collectView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func navigationSetting() {
        navigationItem.title = "Home"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // MARK: UIEventBinding
    
    func uiEventBinding() {
        
        self.searchBar.rx.searchButtonClicked
            .asObservable()
            .map { [weak self] _ in self?.searchBar.text ?? ""}
            .bind(to: viewModel.movieSearch )
            .disposed(by: self.disposedBag)
        
        
    }
    
    // MARK: Rx UIBinding
    
    func uiStateBinding() {
        
        self.collectView.rx.setDelegate(self).disposed(by: self.disposedBag)
        
        viewModel.movieSearchAction
            .do(onNext: { [weak self] _ in
                UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1,
                               initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    self?.backView.alpha = 0.5
                    self?.searchBar.resignFirstResponder()
                }, completion: nil)
               
            })
            .drive(onNext: {
                print($0)
            })
            .disposed(by: self.disposedBag)
    }
    
   
    
    @objc func backViewTapped(_ sender: UITapGestureRecognizer) {
        print("1234")
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.backView.alpha = 0
        }, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectView.bounds.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
}
