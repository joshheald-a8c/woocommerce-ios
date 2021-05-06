import Foundation
import Yosemite

struct CouponListCellViewModel {
    /// Title for a coupon cell: contains the coupon code
    ///
    let title: String

    /// Subtitle for a coupon cell: contains coupon details such as discount, usage limits, and expiry date
    ///
    let subtitle: String?

    /// AccessibilityLabel for a coupon cell: contains code and coupon details
    ///
    let accessibilityLabel: String

    /// Creates a new CouponListCellViewModel, creating strings suitable for showing the
    /// coupon to the user.
    /// - Parameters:
    ///   - coupon: The coupon to display
    ///   - currencySettings: Current site's currency settings for showing currency strings
    ///
    init(coupon: Coupon, currencySettings: CurrencySettings = ServiceLocator.currencySettings) {
        title = coupon.code.uppercased()
        subtitle = Self.cellSubtitle(for: coupon, using: currencySettings)
        accessibilityLabel = Self.cellAccessibilityLabel(for: coupon, using: currencySettings)
    }

    // MARK: - Formatters
    //
    private static var percentageFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.multiplier = 1
        return formatter
    }()
}


// MARK: - Subtitle generation
//
private extension CouponListCellViewModel {
    /// Creates the subtitle for a coupon cell, to show key details about the coupon to the merchant
    ///
    /// - Parameter coupon: the coupon to describe
    /// - Returns: `String?` with up to three components,
    ///     1. The discount amount, as a percentage or currency amount
    ///     2. The usage restrictions, as 'x/y used' or 'Unlimited usage
    ///     3. The expiry date, formated to medium length
    ///
    ///     e.g. "$10 off • Unlimited usage • Expires Sep 27, 2011"
    ///
    private static func cellSubtitle(for coupon: Coupon,
                                     using currencySettings: CurrencySettings) -> String {
        let discountComponent = discountSubtitleComponent(for: coupon,
                                                          using: currencySettings)
        let limitsComponent = limitsSubtitleComponent(for: coupon)
        let expiryComponent: String? = expirySubtitleComponent(for: coupon)

        switch (discountComponent, limitsComponent, expiryComponent) {
        case (let discount?, let limits, let expiry?):
            let template = Localization.couponListCellSubtitleFormatDiscountLimitsAndExpiry
            return String.localizedStringWithFormat(template, discount, limits, expiry)

        case (let discount?, let limits, _):
            let template = Localization.couponListCellSubtitleFormatDiscountAndLimits
            return String.localizedStringWithFormat(template, discount, limits)

        case (_, let limits, let expiry?):
            let template = Localization.couponListCellSubtitleFormatLimitsAndExpiry
            return String.localizedStringWithFormat(template, limits, expiry)

        case (_, let limits, _):
            let template = "%@"
            return String.localizedStringWithFormat(template, limits)
        }
    }

    /// A string describing the discount that is provided by a coupon, as a percentage or
    /// currency amount, if present
    /// - Parameter coupon: the coupon to describe
    /// - Returns: percentage or currency string, e.g. 12.5% off or $12.50
    ///     Will return nil when the amount is 0
    ///
    private static func discountSubtitleComponent(for coupon: Coupon,
                                                  using currencySettings: CurrencySettings) -> String? {
        guard let couponAmount = Double(coupon.amount),
              couponAmount > 0 else {
            return freeShippingDiscountSubtitleComponent(for: coupon)
        }

        switch coupon.discountType {
        case .percent:
            if let couponAmountNumber = couponAmount as NSNumber?,
               let discount = percentageFormatter.string(from: couponAmountNumber) {
                let template = Localization.percentageDiscountAmountSubtitleComponent
                return String.localizedStringWithFormat(template, discount)
            }

        case .fixedCart, .fixedProduct:
            let currencyFormatter = CurrencyFormatter(currencySettings: currencySettings)
            if let discount = currencyFormatter.formatHumanReadableAmount(coupon.amount) {
                let template = Localization.percentageDiscountAmountSubtitleComponent
                return String.localizedStringWithFormat(template, discount)
            }
        }

        return nil
    }

    private static func freeShippingDiscountSubtitleComponent(for coupon: Coupon) -> String? {
        if coupon.freeShipping {
            return Localization.freeShippingDiscountAmountSubtitleComponent
        } else {
            return nil
        }
    }

    /// A string describing the usage limits on a coupon
    /// - Parameter coupon: the coupon to describe
    /// - Returns: a string either describing "x/y used", the number of uses per user,
    ///     or that the coupon is unlimited.
    ///
    ///     e.g. "1/30 used", "One time use", "2 per user" or "Unlimited usage"
    ///
    private static func limitsSubtitleComponent(for coupon: Coupon) -> String {
        if let perUserLimit = coupon.usageLimitPerUser,
           perUserLimit > 0 {
            if perUserLimit == 1 {
                return Localization.OneUsePerPersonLimitsSubtitleComponent
            } else {
                let template = Localization.MultipleUsePerPersonLimitsSubtitleComponent
                return String.localizedStringWithFormat(template, perUserLimit)
            }
        } else if let usageLimit = coupon.usageLimit,
           usageLimit > 0 {
            let template = Localization.xOfYUsageLimitsSubtitleComponent
            return String.localizedStringWithFormat(template, coupon.usageCount, usageLimit)
        } else {
            return Localization.unlimitedUsageLimitsSubtitleComponent
        }
    }

    /// A string describing the expiry date of the coupon, if present.
    /// - Parameter coupon: the coupon to describe
    /// - Returns: a string such as "Expires Sep 27, 2011"
    private static func expirySubtitleComponent(for coupon: Coupon) -> String? {
        if let expiryDate = coupon.dateExpires {
            let template = Localization.expiryDateSubtitleComponent
            let dateString = DateFormatter.mediumLengthLocalizedDateFormatter.string(from: expiryDate)
            return String.localizedStringWithFormat(template, dateString)
        }

        return nil
    }
}


// MARK: - Accessibility label generation
private extension CouponListCellViewModel {
    static func cellAccessibilityLabel(for coupon: Coupon,
                                       using currencySettings: CurrencySettings) -> String {
        let template = Localization.couponListCellAccessibilityLabelFormat
        return String.localizedStringWithFormat(template, coupon.code, Self.cellSubtitle(for: coupon,
                                                                                         using: currencySettings))
    }
}

// MARK: - Localization
//
private extension CouponListCellViewModel {
    enum Localization {
        static let percentageDiscountAmountSubtitleComponent = NSLocalizedString(
            "%1$@ off",
            comment: "Cell subtitle component to display a percentage " +
                "discount offered by a coupon. %1$@ is a placeholder for " +
                "the discount percentage, which will be localized by iOS")

        static let currencyDiscountAmountSubtitleComponent = NSLocalizedString(
            "%1$@ off",
            comment: "Cell subtitle component to display a fixed currency " +
                "discount offered by a coupon. %1$@ is a placeholder for " +
                "the discount amount, which will be localized by iOS " +
                "including the correct currency symbol.")

        static let freeShippingDiscountAmountSubtitleComponent = NSLocalizedString(
            "Free shipping",
            comment: "Cell subtitle component to display a that a coupon " +
                "offers free shipping. Only shown if the coupon offers " +
                "no other discount")

        static let unlimitedUsageLimitsSubtitleComponent = NSLocalizedString(
            "Unlimited usage",
            comment: "Cell subtitle component indicating that the coupon " +
                "can be used an unlimited number of times")

        static let xOfYUsageLimitsSubtitleComponent = NSLocalizedString(
            "%1$ld/%2$ld used",
            comment: "Cell subtitle component indicating the number of " +
                "times the coupon can be used overall, and how many times " +
                "it has been used already. %1$ld is a placeholder for " +
                "the number of times used, %2$ld is a placeholder for " +
                "the limit on the number of uses.")

        static let OneUsePerPersonLimitsSubtitleComponent = NSLocalizedString(
            "One time use",
            comment: "Cell subtitle component indicating that the coupon " +
                "can be used only once per user")

        static let MultipleUsePerPersonLimitsSubtitleComponent = NSLocalizedString(
            "%1$ld per person",
            comment: "Cell subtitle component indicating that the coupon " +
                "can be used only %1$ld times per user. %1$ld is a " +
                "placeholder for the number of times, and will always" +
                "be 2 or greater.")

        static let expiryDateSubtitleComponent =  NSLocalizedString(
            "Expires %1$@",
            comment: "Cell subtitle component indicating the expiry " +
                "date for a coupon. %1$@ is a placeholder for the " +
                "formatted expiry date.")

        static let couponListCellSubtitleFormatDiscountAndLimits = NSLocalizedString(
            "%1$@ • %2$@",
            comment: "Format template for the coupon list subtitle, when " +
                "two components present. %1$@ is a placeholder for the " +
                "discount amount component, and %2$@ is a placeholder " +
                "for the usage limits. e.g. '$10 off • 12/50 used'")

        static let couponListCellSubtitleFormatDiscountAndExpiry = NSLocalizedString(
            "%1$@ • %2$@",
            comment: "Format template for the coupon list subtitle, when " +
                "two components present. %1$@ is a placeholder for the " +
                "discount amount component, and %2$@ is a placeholder " +
                "for the expiry date. e.g. '$10 off • Expires Sept 18, 2021'")

        static let couponListCellSubtitleFormatLimitsAndExpiry = NSLocalizedString(
            "%1$@ • %2$@",
            comment: "Format template for the coupon list subtitle, when " +
                "two components present. %1$@ is a placeholder for the " +
                "usage limits component, and %2$@ is a placeholder " +
                "for the expiry date. e.g. 'Unlimited usage • Expires Sept 18, 2021'")

        static let couponListCellSubtitleFormatDiscountLimitsAndExpiry = NSLocalizedString(
            "%1$@ • %2$@ • %3$@",
            comment: "Format template for the coupon list subtitle, when " +
                "three components present. %1$@ is a placeholder for the " +
                "discount amount component, %2$@ is a placeholder for the " +
                "usage limits, and %3$@ is a placeholder for the expiry date. " +
                "e.g. '$10 off • 12/50 used • Expires Sept 18, 2021'")

        static let couponListCellAccessibilityLabelFormat = NSLocalizedString(
            "%1$@: %2$@",
            comment: "Accessibilty label for coupon cell. %1$@ is a " +
                "placeholder for the coupon code, and %2$@ is for the " +
                "cell subtitle, which describes the coupon. " +
                "e.g. 3RST2MK: $10 off • 0/1 used • Expires Jan 20, 2020")
    }
}
