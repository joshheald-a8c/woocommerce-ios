import UIKit

class AddCouponViewController: UIViewController {
    init() {
        super.init(nibName: type(of: self).nibName, bundle: nil)
    }

    override func viewDidLoad() {
        title = Localizable.title
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}

extension AddCouponViewController {
    enum Localizable {
        static let title = NSLocalizedString(
            "Add Coupon",
            comment: "Title for the Add Coupon form screen")
    }
}
