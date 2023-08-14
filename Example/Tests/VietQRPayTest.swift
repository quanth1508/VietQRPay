//
//  VietQRPayTest.swift
//  VietQRPay_Tests
//
//  Created by Quan Tran on 12/08/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import VietQRPay


final class VietQRPayTest: XCTestCase {
    
    /// Nội dung quét được từ mã của VietQR
    private let contentFromVietQR = "00020101021138570010A00000072701270006970403011300110123456780208QRIBFTTA53037045802VN63049E6F"
    /// Kết quả sau khi parse từ mã VietQR
    private var vietQRPay: VietQRPay? = nil
    
    /// Nội dung sẽ build lên QR từ các thông tin truyền vào
    private var contentToBuildVietQR: String? = nil
    
    override func setUp() {
        super.setUp()
        vietQRPay = VietQRPay(content: contentFromVietQR)
        
        let provider = VietQRPay.ProdiverInfo(
            fieldId : VietQRPayField.vietQR.rawValue,
            name    : VietQRPay.ProviderKind.VIETQR.rawValue,
            guid    : VietQRPay.ProviderKind.VIETQR.guid,
            service : .byAccountNumber
        )
        let consumer = VietQRPay.ConsumerInfo(
            bankBin    : "970403",
            bankNumber : "0011012345678"
        )
        contentToBuildVietQR = VietQRPay(
            version    : "01",
            initMethod : "11",
            currency   : "704",
            nation     : "VN",
            provider   : provider,
            consumer   : consumer
        )
        .build()
    }
    
    func testBuildVietQRPay() throws {
        XCTAssertTrue(contentToBuildVietQR == contentFromVietQR)
    }
    
    func testContentFromVietQRPay() throws {
        XCTAssertTrue(vietQRPay?.provider.guid == VietQRPay.ProviderKind.VIETQR.guid)
        
        XCTAssertTrue(vietQRPay?.provider.service == .byAccountNumber)
        
        XCTAssertTrue(vietQRPay?.consumer.bankBin == "970403")
        
        XCTAssertTrue(vietQRPay?.consumer.bankNumber == "0011012345678")
        
        XCTAssertTrue(vietQRPay?.crc == "9E6F")
    }
}
