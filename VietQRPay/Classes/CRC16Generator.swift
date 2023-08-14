//
//  CRC16Generator.swift
//  VietQRPay
//
//  Created by Quan Tran on 12/08/2023.
//

import Foundation


class CRC16Generator {
    static
    func straight_16(value: UInt16) -> UInt16 {
        return value
    }
    
    static
    func straight_8(value: UInt8) -> UInt8 {
        return value
    }
    
    static
    func crc16(data: Data, remainder: UInt16, polynomial: UInt16, data_order: (_ value: UInt8) -> UInt8, remainder_order: (_ value: UInt16) -> UInt16) -> UInt16 {
        var remainder = remainder
        
        for byte in data {
            remainder ^= UInt16(data_order(byte)) << 8
            for _ in 0..<8 {
                if (remainder & 0x8000) != 0 {
                    remainder = (remainder << 1) ^ polynomial
                } else {
                    remainder = (remainder << 1)
                }
            }
        }
        return remainder_order(remainder)
    }
    
    static
    func crc16ccitt(from data: Data) -> UInt16 {
        return crc16(data: data, remainder: 0xffff, polynomial: 0x1021, data_order: straight_8, remainder_order: straight_16)
    }
}
