public protocol UserInfoRepresentable {
    init(userInfo: [AnyHashable: Any])
    func convertToUserInfo() -> [AnyHashable: Any]
}
