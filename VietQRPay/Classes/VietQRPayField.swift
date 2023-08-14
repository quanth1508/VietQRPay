//
//  VietQRPayField.swift
//  VietQRPay
//
//  Created by Quan Tran on 12/08/2023.
//

import Foundation


/// Cấu trúc dữ liệu gốc NAPAS247
public
enum VietQRPayField: String {
    /// Phiên bản dữ liệu
    case version          = "00"
    /// Phương thức khởi tạo
    case initMethod       = "01"
    /// Thông tin định danh ĐVCNTT VietQR
    case vietQR           = "38"
    /// Mã danh mục ĐVCNTT
    case category         = "52"
    /// Mã tiền tệ
    case currency         = "53"
    /// Số tiền GD
    case amount           = "54"
    /// Chỉ thị cho Tip và Phí GD
    case tipAndFeeType    = "55"
    /// Giá trị phí cố định
    case tipAndFeeAmount  = "56"
    /// Giá trị phí tỷ lệ phần trăm
    case tipAndFeePercent = "57"
    /// Mã quốc gia
    case nation           = "58"
    /// Tên ĐVCNTT
    case acquier          = "59"
    /// Thành phố của ĐVCNTT
    case city             = "60"
    /// Mã bưu điện
    case zipCode          = "61"
    /// Thông tin bổ sung
    case additionalData   = "62"
    /// Cyclic Redundancy Check
    case crc              = "63"
}


extension VietQRPayField {
    public
    enum ProviderFieldID: String {
      case guid     = "00"
      case consumer = "01"
      case service  = "02"
    }
    
    public
    enum Sevice: String {
      /// Dịch vụ chuyển nhanh đến Tài khoản
      case byAccountNumber = "QRIBFTTA"
      /// Dịch vụ chuyển nhanh đến Thẻ
      case byCardNumber    = "QRIBFTTC"
    }

    public
    enum ConsumerField: String {
      case bankBin    = "00"
      case bankNumber = "01"
    }
    
    public
    enum AdditionalDataField: String {
      /// Số hóa đơn
      case billNumber                      = "01"
      /// Số ĐT
      case mobileNumber                    = "02"
      /// Mã cửa hàng
      case storeLabel                      = "03"
      /// Mã khách hàng thân thiết
      case loyaltyNumber                   = "04"
      /// Mã tham chiếu
      case referenceLabel                  = "05"
      /// Mã khách hàng
      case customerLabel                   = "06"
      /// Mã số điểm bán
      case terminalLabel                   = "07"
      /// Mục đích giao dịch/
      case purposeOfTransaction            = "08"
      /// Yêu cầu dữ liệu KH bổ sung
      case additionalConsumerDataRequest   = "09"
    }
}


extension VietQRPay {
    public
    enum ProviderKind: String {
        case VIETQR
        
        public
        var guid: String {
            switch self {
            case .VIETQR:
                return "A000000727"
            }
        }
    }
    
    public
    struct ProdiverInfo {
        public var fieldId : String?
        public var name    : String?
        public var guid    : String?
        public var service : VietQRPayField.Sevice?
        
        public init() { }
        
        public init(
            fieldId : String? = nil,
            name    : String? = nil,
            guid    : String? = nil,
            service : VietQRPayField.Sevice? = nil
        ) {
            self.fieldId = fieldId
            self.name    = name
            self.guid    = guid
            self.service = service
        }
    }

    public
    struct QRPayAdditionalInfo {
        public var billNumber    : String?
        public var mobileNumber  : String?
        public var store         : String?
        public var loyaltyNumber : String?
        public var reference     : String?
        public var customerLabel : String?
        public var terminal      : String?
        public var purpose       : String?
        public var dataRequest   : String?
        
        public init() { }
        
        public init(
            billNumber    : String? = nil,
            mobileNumber  : String? = nil,
            store         : String? = nil,
            loyaltyNumber : String? = nil,
            reference     : String? = nil,
            customerLabel : String? = nil,
            terminal      : String? = nil,
            purpose       : String? = nil,
            dataRequest   : String? = nil
        ) {
            self.billNumber    = billNumber
            self.mobileNumber  = mobileNumber
            self.store         = store
            self.loyaltyNumber = loyaltyNumber
            self.reference     = reference
            self.customerLabel = customerLabel
            self.terminal      = terminal
            self.purpose       = purpose
            self.dataRequest   = dataRequest
        }
    }

    public
    struct ConsumerInfo {
        public var bankBin    : String?
        public var bankNumber : String?
        
        public init() { }
        
        public init(
            bankBin    : String? = nil,
            bankNumber : String? = nil
        ) {
            self.bankBin    = bankBin
            self.bankNumber = bankNumber
        }
    }

    public
    struct MerchantInfo {
        public var merchantId: String?
        
        public init() { }
        
        public init(
            merchantId: String? = nil
        ) {
            self.merchantId = merchantId
        }
    }
}
