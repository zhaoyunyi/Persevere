//
//  BasePageViewModel.swift
//  laoshizaishang
//
//  Created by zhaoyunyi on 2017/10/19.
//  Copyright © 2017年 fragment. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import ObjectMapper
import MJRefresh

public enum RefreshStatus: Int {
    case PushSuccess
    case PushFailure
    case PullSuccess
    case PullFailure
    case NoMoreData
    case HaveEnoughData
    case PullNoData
    case Unknown
}
// 每次取多少个数据
public let maxPageSize = 1

class BasePageViewModel<T: Mappable> {
    
    // 加载信号
    public var loadData = PublishSubject<Int>()
    public var page: Int = 1
    public var dataSource = [SectionModel<String, T>]()
    public var result: Observable<[SectionModel<String, T>]>?
    public var refresh: Variable<RefreshStatus> = Variable(.Unknown)
    
    // 下拉刷新信号
    let refreshTrigger = PublishSubject<Void>()
    let pullMoreTrigger = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    init() {
        
        refreshTrigger
            .subscribe { [weak self] item in
                
                if let strongSelf = self {
                    strongSelf.reloadData()
                }
            }
            .disposed(by: disposeBag)
        
        pullMoreTrigger
            .subscribe { [weak self] item in
                
                if let strongSelf = self {
                    strongSelf.loadMoreData()
                }
            }
            .disposed(by: disposeBag)
        
    }

    public func dealWithRefresh(result: BaseResponse<ListResult<T>>) -> [SectionModel<String, T>] {
        switch result.requestState {
        case .success:
            
            if let data = result.result?.content {
                
                if page == 1 { // 下拉
                    if data.count >= maxPageSize {
                        
                        dataSource = [SectionModel(model: "", items: data)]
                        refresh.value = .HaveEnoughData
                        return (dataSource)
                    } else if data.count == 0 {
                        
                        dataSource = [SectionModel(model: "", items: data)]
                        refresh.value = .PullNoData
                        return (dataSource)
                    } else {
                        dataSource = [SectionModel(model: "", items: data)]
                        refresh.value = .PullSuccess
                        return (dataSource)
                    }
                } else { // 上拉翻页
                    if data.count == 0 { // 无更多数据
                        page -= 1
                        refresh.value = .NoMoreData
                        return (dataSource)
                    } else {
                        dataSource += [SectionModel(model: "", items: data)]
                        refresh.value = .PushSuccess
                        return (dataSource)
                    }
                }
            } else {
                if page != 1 {
                    page -= 1
                    refresh.value = .PushFailure
                }else {
                    refresh.value = .PullFailure
                }
            }
        case .failed:
            
            if page != 1 {
                page -= 1
                refresh.value = .PushFailure
            }else {
                refresh.value = .PullFailure
            }
        }
        
        return [SectionModel(model: "", items: [])]
    }
    
    // 下拉刷新
    func reloadData() {
        page = 1
        loadData.onNext(page)
    }
    // 上拉加载
    func loadMoreData() {
        page += 1
        loadData.onNext(page)
    }
}


public protocol RefreshScrollViewProtocol {
    
}

extension RefreshScrollViewProtocol {
    func refreshStatus(status: RefreshStatus, scrollView: UIScrollView) {
        switch status {
        case .PullSuccess:
            scrollView.mj_header.endRefreshing()
        case .PushSuccess:
            scrollView.mj_footer.endRefreshing()
        case .PullFailure:
            scrollView.mj_header.endRefreshing()
        case .PushFailure:
            scrollView.mj_footer.endRefreshing()
        case .NoMoreData :
            scrollView.mj_footer.endRefreshingWithNoMoreData()
        case .HaveEnoughData:
            scrollView.mj_header.endRefreshing()
        case .PullNoData:
            scrollView.mj_header.endRefreshing()
        case .Unknown:break
        }
    }
}

extension Reactive where Base: UIScrollView {
    
    // 设置下拉刷新的信号量
    func refreshTop(tableView: UIScrollView) -> Observable<Void> {
        
        return Observable.create {observer in
            let head = MJRefreshStateHeader{ () -> Void in
                
                if tableView.mj_footer != nil {
                    tableView.mj_footer.resetNoMoreData()
                }
                // 发送下一个信号
                observer.onNext(())
            }
            
            tableView.mj_header = head
            
            return Disposables.create()
        }
    }
    
    // 设置下拉刷新的信号量
    func refreshBottom(tableView: UIScrollView) -> Observable<Void> {
        
        return Observable.create {observer in
            let footer = MJRefreshAutoStateFooter{ () -> Void in
                // 发送下一个信号
                observer.onNext(())
            }
            //            footer?.isAutomaticallyHidden = true
            //            footer?.isAutomaticallyRefresh = false
            //            footer?.setTitle("", for: MJRefreshState.idle)
            //            tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0)
            footer?.setTitle("暂无更多数据", for: MJRefreshState.noMoreData)
            //            footer?.isAutomaticallyChangeAlpha = true
            tableView.mj_footer = footer
            
            return Disposables.create()
        }
    }
    
    //    var reachedBottom: Observable<Void> {
    //
    //        return contentOffset
    //            .flatMap { [weak base] contentOffset -> Observable<Void> in
    //                guard let scrollView = base else {
    //                    return Observable.empty()
    //                }
    //
    //                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
    //                let y = contentOffset.y + scrollView.contentInset.top
    //                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
    //
    //                return y > threshold ? Observable.just() : Observable.empty()
    //        }
    //    }
}
