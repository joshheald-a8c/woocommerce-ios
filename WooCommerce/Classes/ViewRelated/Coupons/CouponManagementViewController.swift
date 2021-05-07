import UIKit
import WordPressUI

final class CouponManagementViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
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
            tableView.reloadData()
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension

        tableView.addSubview(refreshControl)
    }

    func registerTableViewCells() {
        tableView.registerNib(for: TitleBodyTableViewCell.self)
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
        tableView.displayGhostContent(options: options,
                                       style: .wooDefaultGhostStyle)
    }

    /// Removes the Placeholder Coupons
    ///
    func removePlaceholderCoupons() {
        tableView.removeGhostContent()
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
            image: .errorImage,
            details: Localization.emptyStateDetails,
            buttonTitle: "") { _ in }

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
        view.pinSubviewToAllEdges(emptyStateViewController.view)

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


// MARK: - TableView Delegate
//
extension CouponManagementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.tableWillDisplayCell(at: indexPath)
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

        static let emptyStateMessage = NSLocalizedString(
            "No coupons yet",
            comment: "The text on the placeholder overlay when there are no coupons on the coupon management list")

        static let emptyStateDetails = NSLocalizedString(
            "Market your products by adding a coupon to offer your customers a discount.",
            comment: "The details on the placeholder overlay when there are no coupons on the coupon management list")
    }
}
