import XCTest
@testable import WooCommerce
import Yosemite

final class CouponListCellViewModelTests: XCTestCase {
    func test_coupon_cell_view_model_has_uppercased_code_for_title() {
        // Given
        let coupon = Coupon.fake().copy(siteID: 123, code: "10off")

        // When
        let sut = CouponListCellViewModel(coupon: coupon)

        // Then
        XCTAssertEqual(sut.title, "10OFF")
    }

    func test_coupon_cell_view_model_for_percent_coupon_has_percent_off_unlimited_usage_for_subtitle() {
        // Given
        let coupon = Coupon.fake().copy(siteID: 123,
                                        code: "10percentoff",
                                        amount: "10",
                                        discountType: .percent)

        // When
        let sut = CouponListCellViewModel(coupon: coupon)

        // Then
        XCTAssertEqual(sut.subtitle, "10% off • Unlimited usage")
    }

    func test_coupon_cell_view_model_for_fixedCart_coupon_has_currency_off_unlimited_usage_for_subtitle() {
        // Given
        let coupon = Coupon.fake().copy(siteID: 123,
                                        code: "10dollarsoff",
                                        amount: "10.00",
                                        discountType: .fixedCart)

        // When
        let sut = CouponListCellViewModel(coupon: coupon,
                                          currencySettings: CurrencySettings())

        // Then
        XCTAssertEqual(sut.subtitle, "$10 off • Unlimited usage")
    }

    func test_coupon_cell_view_model_for_fixedProduct_coupon_has_currency_off_unlimited_usage_for_subtitle() {
        // Given
        let coupon = Coupon.fake().copy(siteID: 123,
                                        code: "10dollarsoff",
                                        amount: "10.00",
                                        discountType: .fixedProduct)

        // When
        let sut = CouponListCellViewModel(coupon: coupon,
                                          currencySettings: CurrencySettings())

        // Then
        XCTAssertEqual(sut.subtitle, "$10 off • Unlimited usage")
    }

    func test_coupon_cell_view_model_for_1of3_uses_coupon_has_correct_limits() {
        // Given
        let coupon = Coupon.fake().copy(siteID: 123,
                                        code: "10dollarsoff",
                                        amount: "10.00",
                                        discountType: .fixedProduct,
                                        usageCount: 1,
                                        usageLimit: 3)

        // When
        let sut = CouponListCellViewModel(coupon: coupon,
                                          currencySettings: CurrencySettings())

        // Then
        XCTAssertEqual(sut.subtitle, "$10 off • 1/3 used")
    }

    func test_coupon_cell_view_model_coupon_with_expiry_includes_formatted_date() {
        // Given
        let date = Date(timeIntervalSince1970: 1317078000)
        let coupon = Coupon.fake().copy(siteID: 123,
                                        code: "10dollarsoff",
                                        amount: "10.00",
                                        discountType: .fixedProduct,
                                        dateExpires: date)

        // When
        let sut = CouponListCellViewModel(coupon: coupon,
                                          currencySettings: CurrencySettings())

        // Then
        XCTAssertEqual(sut.subtitle, "$10 off • Unlimited usage • Expires Sep 27, 2011")
    }

    func test_coupon_cell_view_model_for_coupon_without_amount_with_free_shipping_has_free_shipping() {
        // Given
        let coupon = Coupon.fake().copy(siteID: 123,
                                        code: "AAABBBCCC",
                                        freeShipping: true)

        // When
        let sut = CouponListCellViewModel(coupon: coupon)

        // Then
        XCTAssertEqual(sut.subtitle, "Free shipping • Unlimited usage")
    }

    func test_coupon_cell_view_model_for_coupon_without_amount_or_expiry_has_limits_only() {
        // Given
        let coupon = Coupon.fake().copy(siteID: 123,
                                        code: "10dollarsoff")

        // When
        let sut = CouponListCellViewModel(coupon: coupon)

        // Then
        XCTAssertEqual(sut.subtitle, "Unlimited usage")
    }

    func test_coupon_cell_view_model_for_coupon_with_amount_0_and_usageLimit_0_has_unlimited_usage() {
        // Given
        let coupon = Coupon.fake().copy(siteID: 123,
                                        code: "10dollarsoff",
                                        amount: "0",
                                        usageLimit: 0)

        // When
        let sut = CouponListCellViewModel(coupon: coupon)

        // Then
        XCTAssertEqual(sut.subtitle, "Unlimited usage")
    }

    func test_coupon_cell_view_model_coupon_with_expiry_includes_details_in_accessibility_label() {
        // Given
        let date = Date(timeIntervalSince1970: 1317078000)
        let coupon = Coupon.fake().copy(siteID: 123,
                                        code: "10dollarsoff",
                                        amount: "10.00",
                                        discountType: .fixedProduct,
                                        dateExpires: date)

        // When
        let sut = CouponListCellViewModel(coupon: coupon,
                                          currencySettings: CurrencySettings())

        // Then
        XCTAssertEqual(sut.accessibilityLabel, "10dollarsoff: $10 off • Unlimited usage • Expires Sep 27, 2011")
    }

    func test_coupon_cell_view_model_for_coupon_with_usageLimitPerUser_1_has_one_time_use() {
        // Given
        let coupon = Coupon.fake().copy(siteID: 123,
                                        code: "10dollarsoff",
                                        usageLimitPerUser: 1)

        // When
        let sut = CouponListCellViewModel(coupon: coupon)

        // Then
        XCTAssertEqual(sut.subtitle, "One time use")
    }

    func test_coupon_cell_view_model_for_coupon_with_usageLimitPerUser_1_usageLimit_30_has_one_time_use() {
        // Given
        let coupon = Coupon.fake().copy(siteID: 123,
                                        code: "10dollarsoff",
                                        usageLimit: 30,
                                        usageLimitPerUser: 1)

        // When
        let sut = CouponListCellViewModel(coupon: coupon)

        // Then
        XCTAssertEqual(sut.subtitle, "One time use")
    }

    func test_coupon_cell_view_model_for_coupon_with_usageLimitPerUser_2_has_two_per_person() {
        // Given
        let coupon = Coupon.fake().copy(siteID: 123,
                                        code: "10dollarsoff",
                                        usageLimit: 30,
                                        usageLimitPerUser: 2)

        // When
        let sut = CouponListCellViewModel(coupon: coupon)

        // Then
        XCTAssertEqual(sut.subtitle, "2 per person")
    }
}
