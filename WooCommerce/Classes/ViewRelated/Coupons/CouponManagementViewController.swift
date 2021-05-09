import UIKit
import WordPressUI

final class CouponManagementViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet weak var addCouponButton: UIButton!
    @IBOutlet weak var addCouponSeparator: UIView!
    @IBOutlet weak var addCouponButtonContainer: UIView!
    private var viewModel: CouponManagementListViewModel!

    /// Set when an empty state view controller is displayed.
    ///
    private var emptyStateViewController: UIViewController?

    /// Footer "Loading More" Spinner.
    ///
    private lazy var footerSpinnerView = FooterSpinnerView()

    /// Empty Footer Placeholder. Replaces spinner view and allows footer to collapse and be completely hidden.
    ///
    private lazy var footerEmptyView = UIView(frame: .zero)

    /// Pull To Refresh Support.
    ///
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh(sender:)), for: .valueChanged)
        return refreshControl
    }()

    init(siteID: Int64) {
        super.init(nibName: type(of: self).nibName, bundle: nil)
        self.viewModel = CouponManagementListViewModel(siteID: siteID,
                                                       didLeaveState: didLeave(state:),
                                                       didEnterState: didEnter(state:))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
        configureAddButton()
        configureAddButtonSeparatorView()
        viewModel.viewDidLoad()
    }

    // MARK: - View state updates
    //
    private func didLeave(state: CouponListState) {
        switch state {
        case .empty:
            removeNoResultsOverlay()
        case .loading:
            removePlaceholderCoupons()
        case .loadingNextPage:
            stopFooterLoadingIndicator()
        case .refreshing:
            refreshControl.endRefreshing()
        default:
            break
        }
    }

    private func didEnter(state: CouponListState) {
        switch state {
        case .loading:
            displayPlaceholderCoupons()
        case .coupons:
            tableView?.reloadData()
        case .failed:
            displayCouponScreenError()
        case .empty:
            displayNoResultsOverlay()
        case .loadingNextPage:
            startFooterLoadingIndicator()
        default:
            break
        }
    }
}


// MARK: - View Configuration
//
private extension CouponManagementViewController {

    func configureNavigation() {
        title = Localization.title
    }

    func configureTableView() {
        registerTableViewCells()
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.estimatedRowHeight = Constants.estimatedRowHeight
        tableView?.rowHeight = UITableView.automaticDimension

        tableView?.addSubview(refreshControl)
    }

    func registerTableViewCells() {
        tableView?.registerNib(for: TitleBodyTableViewCell.self)
    }

    func configureAddButton() {
        addCouponButton.setTitle(Localization.addNewCouponButtonTitle, for: .normal)
        addCouponButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addCouponButton.applySecondaryButtonStyle()
    }

    func configureAddButtonSeparatorView() {
        addCouponSeparator.backgroundColor = .systemColor(.separator)
    }
}


// MARK: - Placeholder cells
//
extension CouponManagementViewController {
    /// Renders the Placeholder Coupons
    ///
    func displayPlaceholderCoupons() {
        let options = GhostOptions(displaysSectionHeader: false,
                                   reuseIdentifier: TitleBodyTableViewCell.reuseIdentifier,
                                   rowsPerSection: Constants.placeholderRowsPerSection)
        tableView?.displayGhostContent(options: options,
                                       style: .wooDefaultGhostStyle)
    }

    /// Removes the Placeholder Coupons
    ///
    func removePlaceholderCoupons() {
        tableView?.removeGhostContent()
    }
}


// MARK: - Empty state view controller
//
extension CouponManagementViewController {
    /// Displays the overlay when there are no results.
    ///
    func displayNoResultsOverlay() {
        let emptyStateViewController = EmptyStateViewController(style: .list)
        let config = EmptyStateViewController.Config.withButton(
            message: .init(string: Localization.emptyStateMessage),
            image: .emptyCouponsImage,
            details: Localization.emptyStateDetails,
            buttonTitle: Localization.emptyStateButtonTitle) { [weak self] _ in
            self?.addButtonTapped()
        }

        displayEmptyStateViewController(emptyStateViewController)
        emptyStateViewController.configure(config)
    }

    /// Shows the EmptyStateViewController as a child view controller.
    ///
    func displayEmptyStateViewController(_ emptyStateViewController: UIViewController) {
        self.emptyStateViewController = emptyStateViewController
        addChild(emptyStateViewController)

        emptyStateViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateViewController.view)

        NSLayoutConstraint.activate([
            emptyStateViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        emptyStateViewController.didMove(toParent: self)
    }

    /// Removes EmptyStateViewController child view controller if applicable.
    ///
    func removeNoResultsOverlay() {
        guard let emptyStateViewController = emptyStateViewController,
              emptyStateViewController.parent == self
        else { return }

        emptyStateViewController.willMove(toParent: nil)
        emptyStateViewController.view.removeFromSuperview()
        emptyStateViewController.removeFromParent()
        self.emptyStateViewController = nil
    }
}


// MARK: - Header add button
//
extension CouponManagementViewController {
    @objc func addButtonTapped() {
        let viewController = AddCouponViewController()
        show(viewController, sender: self)
    }
}


// MARK: - Footer Spinner View
//
extension CouponManagementViewController {

    /// Starts the loading indicator in the footer, to show that another page is being fetched
    ///
    private func startFooterLoadingIndicator() {
        tableView?.tableFooterView = footerSpinnerView
        footerSpinnerView.startAnimating()
    }

    /// Stops the loading indicator in the footer
    ///
    private func stopFooterLoadingIndicator() {
        footerSpinnerView.stopAnimating()
        tableView?.tableFooterView = footerEmptyView
    }

}


// MARK: - Pull to Refresh
//
extension CouponManagementViewController {

    @objc private func pullToRefresh(sender: UIRefreshControl) {
        viewModel.refreshCoupons()
    }

}

// MARK: - TableView Data Source
//
extension CouponManagementViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.couponViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleBodyTableViewCell.reuseIdentifier, for: indexPath)
        if let cellViewModel = viewModel.couponViewModels[safe: indexPath.row] {
            configure(cell as? TitleBodyTableViewCell, with: cellViewModel)
        }

        return cell
    }

    func configure(_ cell: TitleBodyTableViewCell?, with cellViewModel: CouponListCellViewModel) {
        cell?.titleLabel.text = cellViewModel.title
        cell?.bodyLabel.text = cellViewModel.subtitle
        cell?.accessibilityLabel = cellViewModel.accessibilityLabel
    }

}


// MARK: - Error state
//
extension CouponManagementViewController {
    private func displayCouponScreenError() {
        let notice = Notice(title: Localization.errorMessageTitle,
                            feedbackType: .error,
                            actionTitle: Localization.errorMessageRetryButtonTitle) { [weak self] in
            self?.viewModel.retrySyncAfterError()
        }
        ServiceLocator.noticePresenter.enqueue(notice: notice)
    }
}


// MARK: - TableView Delegate
//
extension CouponManagementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.tableWillDisplayCell(at: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let coupon = viewModel.coupon(at: indexPath) else { return }
        let editViewController = EditCouponViewController(coupon: coupon)
        show(editViewController, sender: self)
    }
}


// MARK: - Nested Types
//
private extension CouponManagementViewController {

    enum Constants {
        static let estimatedRowHeight = CGFloat(86)
        static let placeholderRowsPerSection = [3]
    }

}


// MARK: - Localization
//
private extension CouponManagementViewController {

    enum Localization {
        static let title = NSLocalizedString(
            "Coupons",
            comment: "Coupon management coupon list screen title")

        static let addNewCouponButtonTitle = NSLocalizedString(
            "Add Coupon",
            comment: "The text for the button to add a new coupon on " +
                "the coupon management list. Positioned in the header " +
                "of the list, full width of the screen.")

        static let emptyStateMessage = NSLocalizedString(
            "Everyone loves a deal",
            comment: "The text on the placeholder overlay when there " +
                "are no coupons on the coupon management list")

        static let emptyStateDetails = NSLocalizedString(
            "Boost your business by sending customers special offers " +
                "and discounts.",
            comment: "The details on the placeholder overlay when " +
                "there are no coupons on the coupon management list")

        static let emptyStateButtonTitle = NSLocalizedString(
            "Add coupon",
            comment: "The action button text when there are no coupons " +
                "on the coupon management list. Takes the user to the add " +
                "coupon screen.")

        static let errorMessageTitle = NSLocalizedString(
            "Error retrieving coupons",
            comment: "Error message text displayed in slide up notice " +
                "on the coupon management list when coupons cannot be " +
                "retrieved from the API."
        )

        static let errorMessageRetryButtonTitle = NSLocalizedString(
            "Retry",
            comment: "Retry button title for error message on coupon " +
                "management list when coupons cannot be retrieved from " +
                "the API."
        )
    }

}
