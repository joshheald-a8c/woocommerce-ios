import Foundation
import Networking
import Storage

// MARK: - CouponStore
//
public final class CouponStore: Store {
    private let remote: CouponsRemoteProtocol

    private lazy var sharedDerivedStorage: StorageType = {
        return storageManager.writerDerivedStorage
    }()

    init(dispatcher: Dispatcher,
         storageManager: StorageManagerType,
         network: Network,
         remote: CouponsRemoteProtocol) {
        self.remote = remote
        super.init(dispatcher: dispatcher, storageManager: storageManager, network: network)
    }

    /// Initialize a new CouponStore
    /// - Parameters:
    ///   - dispatcher: The dispatcher used to subscribe to `CouponActions`.
    ///   - storageManager: The storage layer used to store and retrieve persisted coupons.
    ///   - network: The network layer used to fetch Coupons
    ///
    public override convenience init(dispatcher: Dispatcher,
                                     storageManager: StorageManagerType,
                                     network: Network) {
        self.init(dispatcher: dispatcher,
                  storageManager: storageManager,
                  network: network,
                  remote: CouponsRemote(network: network))
    }

    // MARK: - Actions

    /// Registers for supported Actions.
    ///
    override public func registerSupportedActions(in dispatcher: Dispatcher) {
        dispatcher.register(processor: self, for: CouponAction.self)
    }

    /// Receives and executes Actions.
    /// - Parameters:
    ///   - action: An action to handle. Must be a `CouponAction`
    ///
    override public func onAction(_ action: Action) {
        guard let action = action as? CouponAction else {
            assertionFailure("CouponStore received an unsupported action")
            return
        }

        switch action {
        case .synchronizeCoupons(let siteID, let pageNumber, let pageSize, let onCompletion):
            synchronizeCoupons(siteID: siteID,
                               pageNumber: pageNumber,
                               pageSize: pageSize,
                               onCompletion: onCompletion)
        }
    }
}


// MARK: - Services
//
private extension CouponStore {

    /// Synchronizes coupons from a Site with what is persisted in the storage layer.
    /// A successful sync of the first page will delete all coupons for the specified site from
    /// storage, in order to reflect deletions made on other devices.
    ///
    /// - Parameters:
    ///   - siteId: The site to synchronizes coupons for.
    ///   - pageNumber: Page number of coupons to fetch from the API
    ///   - pageSize: Number of coupons per page to fetch from the API
    ///   - onCompletion: Closure to call after sychronizing is complete. Called on the main thread.
    ///   - result: `.success(hasNextPage: Bool)` or `.failure(error: Error)`
    ///
    func synchronizeCoupons(siteID: Int64,
                            pageNumber: Int,
                            pageSize: Int,
                            onCompletion: @escaping (_ result: Result<Bool, Error>) -> Void) {
        remote.loadAllCoupons(for: siteID,
                              pageNumber: pageNumber,
                              pageSize: pageSize) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                onCompletion(.failure(error))

            case .success(let coupons):
                if pageNumber == Default.firstPageNumber {
                    self.deleteStoredCoupons(siteID: siteID)
                }

                let hasNextPage = coupons.count == pageSize
                self.upsertStoredCouponsInBackground(readOnlyCoupons: coupons,
                                                     siteID: siteID) {
                    onCompletion(.success(hasNextPage))
                }
            }
        }
    }
}


// MARK: - Storage: Coupon
//
private extension CouponStore {

    /// Updates or Inserts specified Coupon Entities in a background thread
    /// `onCompletion` will be called on the main thred
    ///
    func upsertStoredCouponsInBackground(readOnlyCoupons: [Networking.Coupon],
                                         siteID: Int64,
                                         onCompletion: @escaping () -> Void) {
        let derivedStorage = sharedDerivedStorage
        derivedStorage.perform { [weak self] in
            self?.upsertStoredCoupons(readOnlyCoupons: readOnlyCoupons,
                                      in: derivedStorage,
                                      siteID: siteID)
        }

        storageManager.saveDerivedType(derivedStorage: derivedStorage) {
            DispatchQueue.main.async(execute: onCompletion)
        }
    }

    /// Updates or Inserts the specified Coupon entities
    ///
    func upsertStoredCoupons(readOnlyCoupons: [Networking.Coupon],
                             in storage: StorageType,
                             siteID: Int64) {
        for coupon in readOnlyCoupons {
            let storageCoupon: Storage.Coupon = {
                if let storedCoupon = storage.loadCoupon(siteID: siteID,
                                                         couponID: coupon.couponID) {
                    return storedCoupon
                }
                return storage.insertNewObject(ofType: Storage.Coupon.self)
            }()

            storageCoupon.update(with: coupon)
        }
    }

    /// Deletes all Storage.Coupon with the specified `siteID`
    ///
    func deleteStoredCoupons(siteID: Int64) {
        let storage = storageManager.viewStorage
        storage.deleteCoupons(siteID: siteID)
        storage.saveIfNeeded()
    }
}
