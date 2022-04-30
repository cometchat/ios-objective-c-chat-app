
//  CometChatNewCallList.swift
//  CometChatUIKit
//  Created by CometChat Inc. on 20/09/19.
//  Copyright ©  2020 CometChat Inc. All rights reserved.

/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 
 CometChatNewCallList:  CometChatNewCallList is a view controller with a list of users. The view controller has all the necessary delegates and methods.
 
 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  */

// MARK: - Importing Frameworks.

import UIKit
import CometChatPro


// MARK: - Declaring Protocol.

public protocol NewCallListDelegate: AnyObject {
    /**
     This method triggers when user taps perticular user in CometChatNewCallList
     - Parameters:
     - conversation: Specifies the `User` Object for selected cell.
     - indexPath: Specifies the indexpath for selected user.
     - Author: CometChat Team
     - Copyright:  ©  2020 CometChat Inc.
    
     */
    func didSelectUserAtIndexPath(user: User, indexPath: IndexPath)
}

/*  ----------------------------------------------------------------------------------------- */

public class CometChatNewCallList: UIViewController {
    
    // MARK: - Declaration of Variables
    
    var userRequest : UsersRequest?
    var tableView: UITableView! = nil
    var safeArea: UILayoutGuide!
    var users: [[User]] = [[User]]()
    var filteredUsers: [User] = [User]()
    weak var delegate : NewCallListDelegate?
    var activityIndicator:UIActivityIndicatorView?
    var searchController:UISearchController = UISearchController(searchResultsController: nil)
    var sectionTitle : UILabel?
    var sections = [String]()
    var sortedKeys = [String]()
    var globalGroupedUsers: [String : [User]] = [:]
    // MARK: - View controller lifecycle methods
    
    override public func loadView() {
        super.loadView()
    
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        self.setupTableView()
        self.setupSearchBar()
        self.setupNavigationBar()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        refreshUsers()
    }
    
    // MARK: - Public Instance methods
    
    /**
     This method specifies the navigation bar title for CometChatNewCallList.
     - Parameters:
     - title: This takes the String to set title for CometChatNewCallList.
     - mode: This specifies the TitleMode such as :
     * .automatic : Automatically use the large out-of-line title based on the state of the previous item in the navigation bar.
     *  .never: Never use a larger title when this item is topmost.
     * .always: Always use a larger title when this item is topmost.
     - Author: CometChat Team
     - Copyright:  ©  2020 CometChat Inc.
    
     */
    @objc public func set(title : String, mode: UINavigationItem.LargeTitleDisplayMode){
        if navigationController != nil{
            navigationItem.title = title.localized()
            navigationItem.largeTitleDisplayMode = mode
            switch mode {
            case .automatic:
                navigationController?.navigationBar.prefersLargeTitles = true
            case .always:
                navigationController?.navigationBar.prefersLargeTitles = true
            case .never:
                navigationController?.navigationBar.prefersLargeTitles = false
            @unknown default:break }
        }
    }
    
    
    /**
     This method specifies the navigation bar color for CometChatNewCallList.
     - Parameters:
     - barColor: This  specifies the navigation bar color.
     - color: This  specifies the navigation bar title color.
     - Author: CometChat Team
     - Copyright:  ©  2020 CometChat Inc.
    
     */
    @objc public func set(barColor :UIColor, titleColor color: UIColor){
        if navigationController != nil{
            // NavigationBar Appearance
            if #available(iOS 13.0, *) {
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.configureWithOpaqueBackground()
                navBarAppearance.titleTextAttributes = [ .foregroundColor: color,.font: UIFont.systemFont(ofSize: 20, weight: .regular) as Any]
                navBarAppearance.largeTitleTextAttributes = [.foregroundColor: color, .font: UIFont.systemFont(ofSize: 35, weight: .bold) as Any]
                navBarAppearance.shadowColor = .clear
                navBarAppearance.backgroundColor = barColor
                navigationController?.navigationBar.standardAppearance = navBarAppearance
                navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
                self.navigationController?.navigationBar.isTranslucent = true
            }
        }
    }
    
    
    // MARK: - Private instance methods.
    
    /**
     This method fetches the list of users from  Server using **UserRequest** Class.
     - Author: CometChat Team
     - Copyright:  ©  2020 CometChat Inc.
    
     */
    private func fetchUsers(){
        activityIndicator?.startAnimating()
        activityIndicator?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = activityIndicator
        tableView.tableFooterView?.isHidden = false
        userRequest?.fetchNext(onSuccess: { (users) in
            if users.count != 0 {
                self.groupUsers(users: users)
            }else{
                DispatchQueue.main.async {
                    self.tableView.restore()
                    self.activityIndicator?.stopAnimating()
                    self.tableView.tableFooterView?.isHidden = true
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    CometChatSnackBoard.showErrorMessage(for: error)
                }
            }
         }
    }
    
    private func fetchNextUsers(){
        activityIndicator?.startAnimating()
        activityIndicator?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = activityIndicator
        tableView.tableFooterView?.isHidden = false
        userRequest?.fetchNext(onSuccess: { (users) in
            if users.count != 0 {
                self.groupUsers(users: users)
            }else{
                DispatchQueue.main.async {
                    self.tableView.restore()
                    self.activityIndicator?.stopAnimating()
                    self.tableView.tableFooterView?.isHidden = true
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    CometChatSnackBoard.showErrorMessage(for: error)
                }
            }
         }
    }
    
    private func groupUsers(users: [User]){
        DispatchQueue.main.async {  [weak self] in
            guard let strongSelf = self else { return }
            if strongSelf.users.isEmpty { strongSelf.tableView?.setEmptyMessage("NO_USERS_FOUND".localized())
            }else{ strongSelf.tableView?.restore() }
        }
        
        let groupedUsers = Dictionary(grouping: users) { (element) -> String in
            guard let name = element.name?.capitalized.trimmingCharacters(in: .whitespacesAndNewlines) else {return ""}
            return (name as NSString).substring(to: 1)
        }
        globalGroupedUsers.merge(groupedUsers, uniquingKeysWith: +)
        for key in groupedUsers.keys {
            if !sortedKeys.contains(key) { sortedKeys.append(key) }
        }
        sortedKeys = sortedKeys.sorted{ $0.lowercased() < $1.lowercased()}
        var staticUsers: [[User]] = [[User]]()
        sortedKeys.forEach { (key) in
            if let value = globalGroupedUsers[key] {
                staticUsers.append(value)
            }
        }
        DispatchQueue.main.async {
            self.users = staticUsers
            self.activityIndicator?.stopAnimating()
            self.tableView.tableFooterView?.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Private instance methods.
    
    /**
     This method fetches the list of users from  Server using **UserRequest** Class.
     - Author: CometChat Team
     - Copyright:  ©  2020 CometChat Inc.
     - See Also:
     [CometChatUserList Documentation](https://prodocs.cometchat.com/docs/ios-ui-screens#section-1-comet-chat-user-list)
     */
    private func refreshUsers(){
        self.globalGroupedUsers.removeAll()
        self.sections.removeAll()
        self.users.removeAll()
        activityIndicator?.startAnimating()
        activityIndicator?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = activityIndicator
        tableView.tableFooterView = activityIndicator
        tableView.tableFooterView?.isHidden = false
        
        if UIKitSettings.userInMode == .all {
            userRequest = UsersRequest.UsersRequestBuilder(limit: 20).build()
        }else if UIKitSettings.userInMode == .friends {
            userRequest = UsersRequest.UsersRequestBuilder(limit: 20).friendsOnly(true).build()
        }else if UIKitSettings.userInMode == .none {
            userRequest = UsersRequest.UsersRequestBuilder(limit: 0).build()
        }else {
         userRequest = UsersRequest.UsersRequestBuilder(limit: 20).build()
        }
        userRequest?.fetchNext(onSuccess: { (users) in
            if users.count != 0 {
                self.groupUsers(users: users)
            }else{
                DispatchQueue.main.async {
                    self.tableView.restore()
                    self.activityIndicator?.stopAnimating()
                    self.tableView.tableFooterView?.isHidden = true
                }
            }
        
        }) { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    CometChatSnackBoard.showErrorMessage(for: error)
                }
            }
        }
    }
    
    /**
     This method setup the tableview to load CometChatNewCallList.
     - Author: CometChat Team
     - Copyright:  ©  2020 CometChat Inc.
    
     */
    private func setupTableView() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
            activityIndicator = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .gray)
        }
        tableView = UITableView()
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.safeArea.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.registerCells()
    }
    
    /**
     This method register 'CometChatUserListItem' cell in tableView.
     - Author: CometChat Team
     - Copyright:  ©  2020 CometChat Inc.
    
     */
    private func registerCells(){
        let CometChatUserListItem  = UINib.init(nibName: "CometChatUserListItem", bundle: UIKitSettings.bundle)
        self.tableView.register(CometChatUserListItem, forCellReuseIdentifier: "CometChatUserListItem")
    }
    
    /**
     This method setup navigationBar for userList viewController.
     - Author: CometChat Team
     - Copyright:  ©  2020 CometChat Inc.
    
     */
    private func setupNavigationBar(){
        if navigationController != nil{
            // NavigationBar Appearance
            if #available(iOS 13.0, *) {
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.configureWithOpaqueBackground()
                navBarAppearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 20, weight: .regular) as Any]
                navBarAppearance.largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 35, weight: .bold) as Any]
                navBarAppearance.shadowColor = .clear
                navigationController?.navigationBar.standardAppearance = navBarAppearance
                navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
                self.navigationController?.navigationBar.isTranslucent = true
            }
            self.addCloseButton(bool: true)
        }}
    
    /**
        This method adds close button in newCall list.
        - Author: CometChat Team
        - Copyright:  ©  2020 CometChat Inc.
       
        */
    private func addCloseButton(bool: Bool){
        if bool == true {
            let closeButton = UIBarButtonItem(title: "CLOSE".localized(), style: .plain, target: self, action: #selector(didCloseButtonPressed))
            closeButton.tintColor = UIKitSettings.primaryColor
            self.navigationItem.rightBarButtonItem = closeButton
        }
    }
    
    /**
     This method triggers when close button is pressed.
     - Author: CometChat Team
     - Copyright:  ©  2020 CometChat Inc.
    
     */
    @objc func didCloseButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /**
     This method setup the search bar for userList viewController.
     - Author: CometChat Team
     - Copyright:  ©  2020 CometChat Inc.
    
     */
    private func setupSearchBar(){
        // SearchBar Apperance
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        if #available(iOS 13.0, *) {
            searchController.searchBar.barTintColor = .systemBackground
        } else {}
        
        if #available(iOS 11.0, *) {
            if navigationController != nil{
                navigationItem.searchController = searchController
            }else{
                if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                    if #available(iOS 13.0, *) {textfield.textColor = .label } else {}
                    if let backgroundview = textfield.subviews.first{
                        backgroundview.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
                        backgroundview.layer.cornerRadius = 10
                        backgroundview.clipsToBounds = true
                    }
                }
                tableView.tableHeaderView = searchController.searchBar
            }
        } else {}
    }
    
    
    /**
     This method returns true if  search bar is empty.
     - Author: CometChat Team
     - Copyright:  ©  2020 CometChat Inc.
    
     */
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    /**
     This method returns true if  search bar is in active state.
     - Author: CometChat Team
     - Copyright:  ©  2020 CometChat Inc.
    
     */
    func isSearching() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
}

/*  ----------------------------------------------------------------------------------------- */

// MARK: - Table view Methods

extension CometChatNewCallList: UITableViewDelegate , UITableViewDataSource {
    
    
    /// This method specifies the number of sections to display list of users. In CometChatNewCallList, the users which has same starting alphabets are clubbed in single section.
    /// - Parameter tableView: An object representing the table view requesting this information.
    public func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching() {
            return 1
        }else{
            return users.count
        }
    }
    
    
    /// This method specifies height for section in CometChatNewCallList
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView .
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    
    /// This method specifiesnumber of rows in CometChatNewCallList
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView .
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching(){
            return filteredUsers.count
        }else{
            return users[safe: section]?.count ?? 0
        }
    }
    
    
    /// This method specifies the height for row in CometChatNewCallList
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView .
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    /// This method specifies the view for user  in CometChatNewCallList
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView .
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = indexPath.section as? Int else { return UITableViewCell() }
        if isSearching() {
    
            if let user = filteredUsers[safe: indexPath.row] {
                let userCell = tableView.dequeueReusableCell(withIdentifier: "CometChatUserListItem", for: indexPath) as! CometChatUserListItem
                userCell.user = user
                return userCell
            }
        } else {

            if let user = users[safe: section]?[safe: indexPath.row] {
                let userCell = tableView.dequeueReusableCell(withIdentifier: "CometChatUserListItem", for: indexPath) as! CometChatUserListItem
                userCell.user = user
                return userCell
            }
        }
        
        return UITableViewCell()
    }
    
    
    /// This method specifies the view for header  in CometChatNewCallList
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView .
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width - 20, height: 25))
        sectionTitle = UILabel(frame: CGRect(x: 10, y: 2, width: returnedView.frame.size.width, height: 25))
        if isSearching() {
            sectionTitle?.text = ""
        }else{
            if let title = ((users[safe: section]?.first?.name?.capitalized ?? "") as? NSString)?.substring(to: 1) {
                sectionTitle?.text = title
            }
        }
        if #available(iOS 13.0, *) {
            sectionTitle?.textColor = .lightGray
            returnedView.backgroundColor = .systemBackground
        } else {}
        returnedView.addSubview(sectionTitle!)
        return returnedView
    }
    
    
    /// This method specifies upcoming cells to be display in tableView
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - cell: The TableViewCell object requesting this information.
    ///   - indexPath: specifies current index for TableViewCell.
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            self.fetchNextUsers()
        }
    }
    
    
    /// This method specified te section index title for current index
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - title: specifies current index title.
    ///   - index: specifies current index.
    public func tableView(_ tableView: UITableView,
                          sectionForSectionIndexTitle title: String,
                          at index: Int) -> Int{
        return index
    }
    
    
    /// This method triggers when particular cell is clicked by the user .
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - indexPath: specifies current index for TableViewCell.
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedUser = tableView.cellForRow(at: indexPath) as? CometChatUserListItem else{
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
        if let user = selectedUser.user {
            let  callDetail = CometChatCallDetails()
            callDetail.set(user: user)
            callDetail.set(title: "", mode: .never)
            navigationController?.pushViewController(callDetail, animated: true)
        }
        delegate?.didSelectUserAtIndexPath(user: selectedUser.user!, indexPath: indexPath)
    }
}

/*  ----------------------------------------------------------------------------------------- */

// MARK: - UISearchResultsUpdating Delegate

extension CometChatNewCallList : UISearchBarDelegate, UISearchResultsUpdating {
    
    /// This method update the list of users as per string provided in search bar
    /// - Parameter searchController: The UISearchController object used as the search bar.
    public func updateSearchResults(for searchController: UISearchController) {
        if UIKitSettings.userInMode == .all {
            userRequest = UsersRequest.UsersRequestBuilder(limit: 20).set(searchKeyword: searchController.searchBar.text ?? "").build()
        }else if UIKitSettings.userInMode == .friends {
            userRequest = UsersRequest.UsersRequestBuilder(limit: 20).friendsOnly(true).set(searchKeyword: searchController.searchBar.text ?? "").build()
        }else if UIKitSettings.userInMode == .none {
            userRequest = UsersRequest.UsersRequestBuilder(limit: 0).set(searchKeyword: searchController.searchBar.text ?? "").build()
        }else {
            userRequest = UsersRequest.UsersRequestBuilder(limit: 20).set(searchKeyword: searchController.searchBar.text ?? "").build()
        }
        userRequest?.fetchNext(onSuccess: { (users) in
            if users.count != 0 {
                self.filteredUsers = users
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView?.restore()
                    self.activityIndicator?.stopAnimating()
                    self.tableView.tableFooterView?.isHidden = true
                }
               
            }else{
                self.filteredUsers = []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator?.stopAnimating()
                    self.tableView.tableFooterView?.isHidden = true
                    self.tableView?.setEmptyMessage("NO_USERS_FOUND".localized())
                }
            }
        }) { (error) in
         
        }
    }
}

/*  ----------------------------------------------------------------------------------------- */
