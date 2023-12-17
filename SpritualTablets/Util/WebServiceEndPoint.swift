//
//  WebServiceEndPoint.swift
//  OHMYW8
//
//  Created by IBM Mac on 16/09/22.
//

import Foundation
var mobileLoginApi = ""
var emailLoginApi = ""

var mobileProfileApi = ""
var emailProfileApi = ""

let BaseURL = "http://iprismacademy.com/"
let baseFolder = "api-firebase/"

var applicationTokenCCAvenue = "https://test.ccavenue.com"

var authBaseUrl = "https://apiuat.ex.indianoil.in/"
var authBaseFolder = "secured/"


let userCreate = "usercreate.php/"
let changePassword = "changepassword.php/"

public struct GetDataKey {
    static let verifyOtpUser = "verifyotpuser.php/"
    static let userLogin = "userlogin.php/" // "userlogin.php/"
    static let resendOtp = "resentotp_user.php/"
    static let getRestarunts = "get_restarent_list.php/"
    static let userProfileUpdate = "userprofile_update.php/"
    static let orderAdd = "order-add.php/"
    static let getOrdersList = "get-orders-list.php/"
    static let getOrderByDate = "getorderby_date.php/"
    static let getProductDetails = "get-products_details.php/" //
    static let getUpcomingOrders = "upcoming_orders.php/"
    static let updateOrders = "update-orders.php/"

    // TO DO APIS

    static let getOrderDetails = "get-order-details.php/"  // needs to show
    static let updateOrderAddress = "update-order-address.php/"
    static let addCart = "add-cart.php/"
    static let getAdressList = "get_address_list.php/"

    static let getCartList = "get_cart_list.php/"
    static let orderAvailibility = "order_availability.php/"

}

