import Foundation


/// Represents a WordPress.com Site.
///
public struct Site: Codable {

    /// WordPress.com Site Identifier.
    ///
    public let siteID: Int64

    /// Site's Name.
    ///
    public let name: String

    /// Site's Description.
    ///
    public let description: String

    /// Site's URL.
    ///
    public let url: String

    /// Short name for site's plan.
    ///
    public let plan: String

    ///  Indicates if there is a WooCommerce Store Active.
    ///
    public let isWooCommerceActive: Bool

    /// Indicates if this site hosts a WordPress Store.
    ///
    public let isWordPressStore: Bool

    /// Time zone identifier of the site (TZ database name).
    ///
    public let timezone: String

    /// Return the website UTC time offset, showing the difference in hours and minutes from UTC, from the westernmost (−12:00) to the easternmost (+14:00).
    ///
    public let gmtOffset: Double

    /// Decodable Conformance.
    ///
    public init(from decoder: Decoder) throws {
        let siteContainer = try decoder.container(keyedBy: SiteKeys.self)

        let siteID = try siteContainer.decode(Int64.self, forKey: .siteID)
        let name = try siteContainer.decode(String.self, forKey: .name)
        let description = try siteContainer.decode(String.self, forKey: .description)
        let url = try siteContainer.decode(String.self, forKey: .url)

        let optionsContainer = try siteContainer.nestedContainer(keyedBy: OptionKeys.self, forKey: .options)
        let isWordPressStore = try optionsContainer.decode(Bool.self, forKey: .isWordPressStore)
        let isWooCommerceActive = try optionsContainer.decode(Bool.self, forKey: .isWooCommerceActive)
        let timezone = try optionsContainer.decode(String.self, forKey: .timezone)
        let gmtOffset = try optionsContainer.decode(Double.self, forKey: .gmtOffset)

        self.init(siteID: siteID,
                  name: name,
                  description: description,
                  url: url,
                  plan: String(), // Not created on init. Added in supplementary API request.
                  isWooCommerceActive: isWooCommerceActive,
                  isWordPressStore: isWordPressStore,
                  timezone: timezone,
                  gmtOffset: gmtOffset)
    }

    /// Encodable Conformance
    ///
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SiteKeys.self)
        try container.encode(siteID, forKey: .siteID)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(url, forKey: .url)

        var optionsContainer = container.nestedContainer(keyedBy: OptionKeys.self, forKey: .options)
        try optionsContainer.encode(isWordPressStore, forKey: .isWordPressStore)
        try optionsContainer.encode(isWooCommerceActive, forKey: .isWooCommerceActive)
        try optionsContainer.encode(timezone, forKey: .timezone)
        try optionsContainer.encode(gmtOffset, forKey: .gmtOffset)
    }

    /// Designated Initializer.
    ///
    public init(siteID: Int64,
                name: String,
                description: String,
                url: String,
                plan: String,
                isWooCommerceActive: Bool,
                isWordPressStore: Bool,
                timezone: String,
                gmtOffset: Double) {
        self.siteID = siteID
        self.name = name
        self.description = description
        self.url = url
        self.plan = plan
        self.isWordPressStore = isWordPressStore
        self.isWooCommerceActive = isWooCommerceActive
        self.timezone = timezone
        self.gmtOffset = gmtOffset
    }
}


// MARK: - Comparable Conformance
//
extension Site: Comparable {
    public static func == (lhs: Site, rhs: Site) -> Bool {
        return lhs.siteID == rhs.siteID &&
            lhs.name == rhs.name &&
            lhs.description == rhs.description &&
            lhs.url == rhs.url &&
            lhs.plan == rhs.plan &&
            lhs.isWooCommerceActive == rhs.isWooCommerceActive &&
            lhs.isWordPressStore == rhs.isWordPressStore &&
            lhs.gmtOffset == rhs.gmtOffset
    }

    public static func < (lhs: Site, rhs: Site) -> Bool {
        return lhs.siteID < rhs.siteID ||
            (lhs.siteID == rhs.siteID && lhs.name < rhs.name) ||
            (lhs.siteID == rhs.siteID && lhs.name == rhs.name && lhs.description < rhs.description)
    }
}


/// Defines all of the Site CodingKeys.
///
private extension Site {

    enum SiteKeys: String, CodingKey {
        case siteID         = "ID"
        case name           = "name"
        case description    = "description"
        case url            = "URL"
        case options        = "options"
        case plan           = "plan"
    }

    enum OptionKeys: String, CodingKey {
        case isWordPressStore = "is_wpcom_store"
        case isWooCommerceActive = "woocommerce_is_active"
        case timezone = "timezone"
        case gmtOffset = "gmt_offset"
    }

    enum PlanKeys: String, CodingKey {
        case shortName      = "product_name_short"
    }
}

/// Computed properties
///
public extension Site {

    /// Returns the TimeZone using the gmtOffset
    ///
    var siteTimezone: TimeZone {
        let secondsFromGMT = Int(gmtOffset * 3600)
        return TimeZone(secondsFromGMT: secondsFromGMT) ?? .current
    }

}
