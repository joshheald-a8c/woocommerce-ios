import UIKit
import Yosemite

final class EditCouponViewController: UIViewController {
    private let coupon: Coupon
    init(coupon: Coupon) {
        self.coupon = coupon
        super.init(nibName: type(of: self).nibName, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        title = Localizable.title
    }
}

extension EditCouponViewController {
    enum Localizable {
        static let title = NSLocalizedString(
            "Edit Coupon",
            comment: "Title for the Edit Coupon form screen")
    }
}
