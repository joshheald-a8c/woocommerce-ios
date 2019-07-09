import XCTest
@testable import Networking


/// OrderStatsV4Mapper Unit Tests
///
final class OrderStatsV4MapperTests: XCTestCase {
    /// Verifies that all of the hourly unit OrderStatsV4 fields are parsed correctly.
    ///
    func testHourlyUnitStatFieldsAreProperlyParsed() {
        guard let hourlyStats = mapOrderStatsWithHourlyUnitResponse() else {
            XCTFail()
            return
        }

        XCTAssertEqual(hourlyStats.totals.orders, 3)
        XCTAssertEqual(hourlyStats.totals.itemsSold, 5)
        XCTAssertEqual(hourlyStats.totals.grossRevenue, 800)
        XCTAssertEqual(hourlyStats.totals.coupons, 0)
        XCTAssertEqual(hourlyStats.totals.couponDiscount, 0)
        XCTAssertEqual(hourlyStats.totals.refunds, 0)
        XCTAssertEqual(hourlyStats.totals.taxes, 0)
        XCTAssertEqual(hourlyStats.totals.shipping, 0)
        XCTAssertEqual(hourlyStats.totals.netRevenue, 800)
        XCTAssertEqual(hourlyStats.totals.products, 2)

        XCTAssertEqual(hourlyStats.intervals.count, 24)

        let nonZeroHour = hourlyStats.intervals[13]
        let nonZeroHourTotals = nonZeroHour.subtotals

        XCTAssertEqual(nonZeroHour.interval, "2019-07-09 13")

        XCTAssertEqual(nonZeroHourTotals.orders, 2)
        XCTAssertEqual(nonZeroHourTotals.grossRevenue, 350)
        XCTAssertEqual(nonZeroHourTotals.coupons, 0)
        XCTAssertEqual(nonZeroHourTotals.couponDiscount, 0)
        XCTAssertEqual(nonZeroHourTotals.refunds, 0)
        XCTAssertEqual(nonZeroHourTotals.taxes, 0)
        XCTAssertEqual(nonZeroHourTotals.shipping, 0)
        XCTAssertEqual(nonZeroHourTotals.netRevenue, 350)
        XCTAssertNil(nonZeroHourTotals.products)
    }

    /// Verifies that all of the daily unit OrderStatsV4 fields are parsed correctly.
    ///
    func testDailyUnitStatFieldsAreProperlyParsed() {
        guard let dailyStats = mapOrderStatsWithDailyUnitResponse() else {
            XCTFail()
            return
        }

        XCTAssertEqual(dailyStats.totals.orders, 3)
        XCTAssertEqual(dailyStats.totals.itemsSold, 5)
        XCTAssertEqual(dailyStats.totals.grossRevenue, 800)
        XCTAssertEqual(dailyStats.totals.coupons, 0)
        XCTAssertEqual(dailyStats.totals.couponDiscount, 0)
        XCTAssertEqual(dailyStats.totals.refunds, 0)
        XCTAssertEqual(dailyStats.totals.taxes, 0)
        XCTAssertEqual(dailyStats.totals.shipping, 0)
        XCTAssertEqual(dailyStats.totals.netRevenue, 800)
        XCTAssertEqual(dailyStats.totals.products, 2)

        XCTAssertEqual(dailyStats.intervals.count, 1)

        let nonZeroDay = dailyStats.intervals[0]
        let nonZeroDayTotals = nonZeroDay.subtotals

        XCTAssertEqual(nonZeroDay.interval, "2019-07-09")

        XCTAssertEqual(nonZeroDayTotals.orders, 3)
        XCTAssertEqual(nonZeroDayTotals.grossRevenue, 800)
        XCTAssertEqual(nonZeroDayTotals.coupons, 0)
        XCTAssertEqual(nonZeroDayTotals.couponDiscount, 0)
        XCTAssertEqual(nonZeroDayTotals.refunds, 0)
        XCTAssertEqual(nonZeroDayTotals.taxes, 0)
        XCTAssertEqual(nonZeroDayTotals.shipping, 0)
        XCTAssertEqual(nonZeroDayTotals.netRevenue, 800)
        XCTAssertNil(nonZeroDayTotals.products)
    }

    /// Verifies that all of the weekly unit OrderStatsV4 fields are parsed correctly.
    ///
    func testWeeklyUnitStatFieldsAreProperlyParsed() {
        guard let weeklyStats = mapOrderStatsWithWeeklyUnitResponse() else {
            XCTFail()
            return
        }

        XCTAssertEqual(weeklyStats.totals.orders, 3)
        XCTAssertEqual(weeklyStats.totals.itemsSold, 5)
        XCTAssertEqual(weeklyStats.totals.grossRevenue, 800)
        XCTAssertEqual(weeklyStats.totals.coupons, 0)
        XCTAssertEqual(weeklyStats.totals.couponDiscount, 0)
        XCTAssertEqual(weeklyStats.totals.refunds, 0)
        XCTAssertEqual(weeklyStats.totals.taxes, 0)
        XCTAssertEqual(weeklyStats.totals.shipping, 0)
        XCTAssertEqual(weeklyStats.totals.netRevenue, 800)
        XCTAssertEqual(weeklyStats.totals.products, 2)

        XCTAssertEqual(weeklyStats.intervals.count, 2)

        let nonZeroWeek = weeklyStats.intervals[0]
        let nonZeroWeekTotals = nonZeroWeek.subtotals

        XCTAssertEqual(nonZeroWeek.interval, "2019-28")

        XCTAssertEqual(nonZeroWeekTotals.orders, 3)
        XCTAssertEqual(nonZeroWeekTotals.grossRevenue, 800)
        XCTAssertEqual(nonZeroWeekTotals.coupons, 0)
        XCTAssertEqual(nonZeroWeekTotals.couponDiscount, 0)
        XCTAssertEqual(nonZeroWeekTotals.refunds, 0)
        XCTAssertEqual(nonZeroWeekTotals.taxes, 0)
        XCTAssertEqual(nonZeroWeekTotals.shipping, 0)
        XCTAssertEqual(nonZeroWeekTotals.netRevenue, 800)
        XCTAssertNil(nonZeroWeekTotals.products)
    }

    /// Verifies that all of the monthly unit OrderStatsV4 fields are parsed correctly.
    ///
    func testMonthlyUnitStatFieldsAreProperlyParsed() {
        guard let monthlyStats = mapOrderStatsWithMonthlyUnitResponse() else {
            XCTFail()
            return
        }

        XCTAssertEqual(monthlyStats.totals.orders, 3)
        XCTAssertEqual(monthlyStats.totals.itemsSold, 5)
        XCTAssertEqual(monthlyStats.totals.grossRevenue, 800)
        XCTAssertEqual(monthlyStats.totals.coupons, 0)
        XCTAssertEqual(monthlyStats.totals.couponDiscount, 0)
        XCTAssertEqual(monthlyStats.totals.refunds, 0)
        XCTAssertEqual(monthlyStats.totals.taxes, 0)
        XCTAssertEqual(monthlyStats.totals.shipping, 0)
        XCTAssertEqual(monthlyStats.totals.netRevenue, 800)
        XCTAssertEqual(monthlyStats.totals.products, 2)

        XCTAssertEqual(monthlyStats.intervals.count, 1)

        let nonZeroMonth = monthlyStats.intervals[0]
        let nonZeroMonthTotals = nonZeroMonth.subtotals

        XCTAssertEqual(nonZeroMonth.interval, "2019-07")

        XCTAssertEqual(nonZeroMonthTotals.orders, 3)
        XCTAssertEqual(nonZeroMonthTotals.grossRevenue, 800)
        XCTAssertEqual(nonZeroMonthTotals.coupons, 0)
        XCTAssertEqual(nonZeroMonthTotals.couponDiscount, 0)
        XCTAssertEqual(nonZeroMonthTotals.refunds, 0)
        XCTAssertEqual(nonZeroMonthTotals.taxes, 0)
        XCTAssertEqual(nonZeroMonthTotals.shipping, 0)
        XCTAssertEqual(nonZeroMonthTotals.netRevenue, 800)
        XCTAssertNil(nonZeroMonthTotals.products)
    }

    /// Verifies that all of the yearly unit OrderStatsV4 fields are parsed correctly.
    ///
    func testYearlyUnitStatFieldsAreProperlyParsed() {
        guard let yearlyStats = mapOrderStatsWithYearlyUnitResponse() else {
            XCTFail()
            return
        }

        XCTAssertEqual(yearlyStats.totals.orders, 3)
        XCTAssertEqual(yearlyStats.totals.itemsSold, 5)
        XCTAssertEqual(yearlyStats.totals.grossRevenue, 800)
        XCTAssertEqual(yearlyStats.totals.coupons, 0)
        XCTAssertEqual(yearlyStats.totals.couponDiscount, 0)
        XCTAssertEqual(yearlyStats.totals.refunds, 0)
        XCTAssertEqual(yearlyStats.totals.taxes, 0)
        XCTAssertEqual(yearlyStats.totals.shipping, 0)
        XCTAssertEqual(yearlyStats.totals.netRevenue, 800)
        XCTAssertEqual(yearlyStats.totals.products, 2)

        XCTAssertEqual(yearlyStats.intervals.count, 1)

        let nonZeroYear = yearlyStats.intervals[0]
        let nonZeroYearTotals = nonZeroYear.subtotals

        XCTAssertEqual(nonZeroYear.interval, "2019")

        XCTAssertEqual(nonZeroYearTotals.orders, 3)
        XCTAssertEqual(nonZeroYearTotals.grossRevenue, 800)
        XCTAssertEqual(nonZeroYearTotals.coupons, 0)
        XCTAssertEqual(nonZeroYearTotals.couponDiscount, 0)
        XCTAssertEqual(nonZeroYearTotals.refunds, 0)
        XCTAssertEqual(nonZeroYearTotals.taxes, 0)
        XCTAssertEqual(nonZeroYearTotals.shipping, 0)
        XCTAssertEqual(nonZeroYearTotals.netRevenue, 800)
        XCTAssertNil(nonZeroYearTotals.products)
    }
}

private extension OrderStatsV4MapperTests {
    /// Returns the OrderStatsV4Mapper output upon receiving `order-stats-v4-hour`
    ///
    func mapOrderStatsWithHourlyUnitResponse() -> OrderStatsV4? {
        return mapStatItems(from: "order-stats-v4-hour")
    }

    /// Returns the OrderStatsV4Mapper output upon receiving `order-stats-v4-default`
    ///
    func mapOrderStatsWithDailyUnitResponse() -> OrderStatsV4? {
        return mapStatItems(from: "order-stats-v4-daily")
    }

    /// Returns the OrderStatsV4Mapper output upon receiving `order-stats-v4-default`
    ///
    func mapOrderStatsWithWeeklyUnitResponse() -> OrderStatsV4? {
        return mapStatItems(from: "order-stats-v4-defaults")
    }

    /// Returns the OrderStatsV4Mapper output upon receiving `order-stats-v4-month`
    ///
    func mapOrderStatsWithMonthlyUnitResponse() -> OrderStatsV4? {
        return mapStatItems(from: "order-stats-v4-month")
    }

    /// Returns the OrderStatsV4Mapper output upon receiving `order-stats-v4-year`
    ///
    func mapOrderStatsWithYearlyUnitResponse() -> OrderStatsV4? {
        return mapStatItems(from: "order-stats-v4-year")
    }

    /// Returns the OrderStatsV4Mapper output upon receiving `filename` (Data Encoded)
    ///
    func mapStatItems(from filename: String) -> OrderStatsV4? {
        guard let response = Loader.contentsOf(filename) else {
            return nil
        }

        return try! OrderStatsV4Mapper().map(response: response)
    }
}
