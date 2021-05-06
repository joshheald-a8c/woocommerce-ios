import Foundation
import Yosemite
import protocol Storage.StorageManagerType
import class AutomatticTracks.CrashLogging


struct CouponListCellViewModel {
    var title: String
    var subtitle: String
    var accessiblityLabel: String
}

enum CouponListState {
    case initialized // ViewModel ready to recieve actions
    case loading // View should show ghost cells
    case empty // View should display the empty state
    case coupons // View should display the contents of `couponViewModels`
    case refreshing // View should display a top loading indicator and the contents of `couponViewModels`
    case loadingNextPage // View should display a bottom loading indicator and contents of `couponViewModels`
}

final class CouponManagementListViewModel {
    /// onListStateChange
    ///
    private var didLeaveState: (CouponListState) -> ()

    /// onListStateChange
    ///
    private var didEnterState: (CouponListState) -> ()

    /// Active state
    ///
    private var state: CouponListState = .initialized {
        didSet {
            guard oldValue != state else {
                return
            }

            didLeaveState(oldValue)
            didEnterState(state)
        }
    }

    /// couponViewModels: ViewModels for the cells representing Coupons
    ///
    var couponViewModels: [CouponListCellViewModel] = []

    /// siteID: siteID of the currently active site, used for fetching and storing coupons
    ///
    private let siteID: Int64

    /// resultsController: provides models from storage used for creation of cell ViewModels
    ///
    private let resultsController: ResultsController<StorageCoupon>

    /// syncingCoordinator: Keeps tracks of which pages have been refreshed, and
    /// encapsulates the "What should we sync now" logic.
    ///
    private let syncingCoordinator: SyncingCoordinatorProtocol

    /// storesManager: provides the store for handling actions
    ///
    private let storesManager: StoresManager

    /// storageManager: provides the storage for the results controller to fetch from
    ///
    private let storageManager: StorageManagerType

    // MARK: - Initialization and setup
    //
    init(siteID: Int64,
         syncingCoordinator: SyncingCoordinatorProtocol = SyncingCoordinator(),
         storesManager: StoresManager = ServiceLocator.stores,
         storageManager: StorageManagerType = ServiceLocator.storageManager,
         didLeaveState: @escaping (CouponListState) -> (),
         didEnterState: @escaping (CouponListState) -> ()) {
        self.siteID = siteID
        self.syncingCoordinator = syncingCoordinator
        self.storesManager = storesManager
        self.storageManager = storageManager
        self.didLeaveState = didLeaveState
        self.didEnterState = didEnterState
        self.resultsController = Self.createResultsController(siteID: siteID,
                                                              storageManager: storageManager)
        configureSyncingCoordinator()
        configureResultsController()
    }

    private static func createResultsController(siteID: Int64,
                                                storageManager: StorageManagerType) -> ResultsController<StorageCoupon> {
        let predicate = NSPredicate(format: "siteID == %lld", siteID)
        let descriptor = NSSortDescriptor(keyPath: \StorageCoupon.dateCreated,
                                          ascending: false)

        return ResultsController<StorageCoupon>(storageManager: storageManager,
                                                matching: predicate,
                                                sortedBy: [descriptor])
    }

    /// Setup: Results Controller
    ///
    private func configureResultsController() {
        resultsController.onDidChangeContent = buildCouponViewModels
        resultsController.onDidResetContent = buildCouponViewModels

        do {
            try resultsController.performFetch()
        } catch {
            CrashLogging.logError(error)
        }
    }

    /// Setup: Syncing Coordinator
    ///
    private func configureSyncingCoordinator() {
        syncingCoordinator.delegate = self
    }

    func buildCouponViewModels() {
        couponViewModels = resultsController.fetchedObjects.map({ coupon in
            return CouponListCellViewModel(title: coupon.code,
                                           subtitle: coupon.description,
                                           accessiblityLabel: coupon.description)
        })
    }


    // MARK: - ViewController actions
    //
    /// The ViewController calls `viewDidLoad` to notify the view model it's ready to recieve results
    ///
    func viewDidLoad() {
        syncingCoordinator.synchronizeFirstPage(reason: nil, onCompletion: nil)
    }

    /// The ViewController may use this method to retrieve a coupon for navigation purposes
    ///
    func coupon(at indexPath: IndexPath) -> Coupon? {
        return resultsController.safeObject(at: indexPath)
    }

    /// The ViewController can trigger loading of the next page when the user scrolls to the bottom
    ///
    func tableWillDisplayCell(at indexPath: IndexPath) {
        syncingCoordinator.ensureNextPageIsSynchronized(lastVisibleIndex: indexPath.row)
    }

    /// The ViewController can trigger a refresh of loaded coupons using pull to refresh
    ///
    func refreshCoupons() {
        syncingCoordinator.resynchronize(reason: nil, onCompletion: nil)
    }
}


// MARK: - SyncingCoordinatorDelegate
//
extension CouponManagementListViewModel: SyncingCoordinatorDelegate {
    /// Syncs the specified page of coupons from the API
    /// - Parameters:
    ///   - pageNumber: 1-indexed page number
    ///   - pageSize: Number of coupons per page
    ///   - reason: A string originating from a call to the coordinator's sync request methods,
    ///   to identify the type of sync required
    ///   - onCompletion: Completion handler to call passing whether the sync was successful
    func sync(pageNumber: Int,
              pageSize: Int,
              reason: String?,
              onCompletion: ((Bool) -> Void)?) {
        transitionToSyncingState(pageNumber: pageNumber,
                                 hasData: couponViewModels.isNotEmpty)
        let action = CouponAction
            .synchronizeCoupons(siteID: siteID,
                                pageNumber: pageNumber,
                                pageSize: pageSize) { [weak self] result in
                guard let self = self else { return }
                self.handleCouponSyncResult(result: result)
                onCompletion?(result.isSuccess)
        }

        storesManager.dispatch(action)
    }

    func handleCouponSyncResult(result: Result<Bool, Error>) {
        switch result {
        case .failure(let error):
            DDLogError("⛔️ Error synchronizing coupons: \(error)")

        case .success:
            DDLogInfo("Synchronized coupons")
        }

        self.transitionToResultsUpdatedState(hasData: couponViewModels.isNotEmpty)
    }
}

// MARK: - Pagination
//
private extension CouponManagementListViewModel {
    func transitionToSyncingState(pageNumber: Int,
                                  hasData: Bool) {
        if pageNumber == 1 {
            if hasData {
                state = .refreshing
            } else {
                state = .loading
            }
        } else {
            state = .loadingNextPage
        }
    }

    func transitionToResultsUpdatedState(hasData: Bool) {
        if hasData {
            state = .coupons
        } else {
            state = .empty
        }
    }
}
