import XCTest
@testable import Networking
import Alamofire

class CouponsRemoteTests: XCTestCase {

    /// Dummy Network Wrapper
    ///
    private var network: MockNetwork!

    /// Dummy Site ID
    ///
    private let sampleSiteID: Int64 = 1234

    override func setUp() {
        super.setUp()
        network = MockNetwork()
    }

    override func tearDown() {
        network = nil
        super.tearDown()
    }

    // MARK: - Load all Coupons tests

    /// Verifies that loadAllCoupons properly parses the `coupons-all` sample response.
    /// 
    func test_loadAllCoupons_returns_parsed_coupons() throws {
        // Given
        let remote = CouponsRemote(network: network)

        network.simulateResponse(requestUrlSuffix: "coupons", filename: "coupons-all")

        // When
        let result = waitFor { promise in
            remote.loadAllCoupons(for: self.sampleSiteID) { result in
                promise(result)
            }
        }

        // Then
        XCTAssert(result.isSuccess)
        guard let coupons = try? result.get() else {
            XCTFail("Expected parsed Coupons not found in response")
            return
        }
        XCTAssertEqual(coupons.count, 2)
    }

    /// Verifies that loadAllCoupons uses the passed in parameters to specify the page of results wanted.
    ///
    func test_loadAllCoupons_uses_passed_pagination_parameters() throws {
        // Given
        let remote = CouponsRemote(network: network)

        // When
        remote.loadAllCoupons(for: sampleSiteID, pageNumber: 2, pageSize: 17) { _ in }

        // Then
        guard let request = network.requestsForResponseData.first as? JetpackRequest else {
            XCTFail("Expected request not enqueued")
            return
        }
        guard let page = request.parameters["page"] as? String,
              let pageSize = request.parameters["per_page"] as? String else {
            XCTFail("Pagination parameters not found")
            return
        }
        XCTAssertEqual(page, "2")
        XCTAssertEqual(pageSize, "17")
    }

    /// Verifies that loadAllCoupons uses the SiteID passed in for the request.
    ///
    func test_loadAllCoupons_uses_passed_siteID_for_request() {
        // Given
        let remote = CouponsRemote(network: network)

        // When
        remote.loadAllCoupons(for: sampleSiteID) { _ in }

        // Then
        guard let request = network.requestsForResponseData.first as? JetpackRequest else {
            XCTFail("Expected request not enqueued")
            return
        }
        XCTAssertEqual(request.siteID, sampleSiteID)
    }

    /// Verifies that loadAllCoupons uses the SiteID passed in to build the models.
    ///
    func test_loadAllCoupons_uses_passed_siteID_for_model_creation() throws {
        // Given
        let remote = CouponsRemote(network: network)

        network.simulateResponse(requestUrlSuffix: "coupons", filename: "coupons-all")

        // When
        let result = waitFor { promise in
            remote.loadAllCoupons(for: self.sampleSiteID) { result in
                promise(result)
            }
        }

        // Then
        let coupons = try result.get()
        XCTAssertEqual(coupons.first?.siteId, sampleSiteID)
    }

    /// Verifies that loadAllCoupons properly relays Networking Layer errors.
    ///
    func test_loadAllCoupons_properly_relays_networking_errors() throws {
        // Given
        let remote = CouponsRemote(network: network)

        let error = NetworkError.unacceptableStatusCode(statusCode: 403)
        network.simulateError(requestUrlSuffix: "coupons", error: error)

        // When
        let result = waitFor { promise in
            remote.loadAllCoupons(for: self.sampleSiteID,
                                  completion: { (result) in
                                    promise(result)
                                })
        }

        // Then
        XCTAssertTrue(result.isFailure)
        guard let resultError = result.failure as? NetworkError else {
            XCTFail("Expected NetworkError not found")
            return
        }
        XCTAssertEqual(resultError, .unacceptableStatusCode(statusCode: 403))
    }

    // MARK: - Delete Coupon tests

    /// Verifies that deleteCoupon properly parses the `coupon` sample response.
    ///
    func test_deleteCoupon_properly_returns_parsed_Coupon() throws {
        // Given
        let remote = CouponsRemote(network: network)
        let sampleCouponID: Int64 = 720

        network.simulateResponse(requestUrlSuffix: "coupons/\(sampleCouponID)", filename: "coupon")

        // When
        let result = waitFor { promise in
            remote.deleteCoupon(for: self.sampleSiteID, couponID: sampleCouponID) { result in
                promise(result)
            }
        }

        // Then
        XCTAssert(result.isSuccess)
        guard let coupon = try? result.get() else {
            XCTFail("Expected parsed Coupon not found in response")
            return
        }
        XCTAssertEqual(coupon.couponId, sampleCouponID)
    }

    /// Verifies that deleteCoupon properly relays Networking Layer errors.
    ///
    func test_deleteCoupon_properly_relays_networking_errors() throws {
        // Given
        let remote = CouponsRemote(network: network)
        let sampleCouponID: Int64 = 1275

        let error = NetworkError.unacceptableStatusCode(statusCode: 500)
        network.simulateError(requestUrlSuffix: "coupons/\(sampleCouponID)", error: error)

        // When
        let result = waitFor { promise in
            remote.deleteCoupon(for: self.sampleSiteID,
                                couponID: sampleCouponID,
                                completion: { (result) in
                promise(result)
            })
        }

        // Then
        XCTAssertTrue(result.isFailure)
        guard let resultError = result.failure as? NetworkError else {
            XCTFail("Expected NetworkError not found")
            return
        }
        XCTAssertEqual(resultError, .unacceptableStatusCode(statusCode: 500))
    }
}
