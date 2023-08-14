//
//  VietQRPay.swift
//  VietQRPay
//
//  Created by Quan Tran on 12/08/2023.
//

import Foundation


public
class VietQRPay {
    public var version          : String?             = nil
    public var initMethod       : String?             = nil
    public var category         : String?             = nil
    public var currency         : String?             = nil
    public var amount           : String?             = nil
    public var tipAndFeeType    : String?             = nil
    public var tipAndFeeAmount  : String?             = nil
    public var tipAndFeePercent : String?             = nil
    public var nation           : String?             = nil
    public var acquier          : String?             = nil
    public var city             : String?             = nil
    public var zipCode          : String?             = nil
    public var crc              : String?             = nil
    public var provider         : ProdiverInfo        = .init()
    public var merchant         : MerchantInfo        = .init()
    public var consumer         : ConsumerInfo        = .init()
    public var additionalData   : QRPayAdditionalInfo = .init()
    
    public
    init(content: String) {
        _parseRoot(content: content)
    }
    
    public init() { }
    
    public init(
        version          : String?             = nil,
        initMethod       : String?             = nil,
        category         : String?             = nil,
        currency         : String?             = nil,
        amount           : String?             = nil,
        tipAndFeeType    : String?             = nil,
        tipAndFeeAmount  : String?             = nil,
        tipAndFeePercent : String?             = nil,
        nation           : String?             = nil,
        acquier          : String?             = nil,
        city             : String?             = nil,
        zipCode          : String?             = nil,
        crc              : String?             = nil,
        provider         : ProdiverInfo        = .init(),
        merchant         : MerchantInfo        = .init(),
        consumer         : ConsumerInfo        = .init(),
        additionalData   : QRPayAdditionalInfo = .init()
    ) {
        self.version          = version
        self.initMethod       = initMethod
        self.category         = category
        self.currency         = currency
        self.amount           = amount
        self.tipAndFeeType    = tipAndFeeType
        self.tipAndFeeAmount  = tipAndFeeAmount
        self.tipAndFeePercent = tipAndFeePercent
        self.nation           = nation
        self.acquier          = acquier
        self.city             = city
        self.zipCode          = zipCode
        self.crc              = crc
        self.provider         = provider
        self.merchant         = merchant
        self.consumer         = consumer
        self.additionalData   = additionalData
    }
    
    private
    func _parseRoot(content: String) {
        guard content.count > 4 else { return }
        let (id, value, nextValue) = _slide(content: content)
        let fieldID = VietQRPayField(rawValue: id)
        guard let fieldID = fieldID else {
            _parseRoot(content: String(content[2..<content.count]))
            return
        }
        
        switch fieldID {
        case .version:
            self.version = value
            
        case .initMethod:
            self.initMethod = value
            
        case .vietQR:
            self.provider.fieldId = id
            _parseProviderInfo(content: value)
            
        case .category:
            self.category = value
            
        case .currency:
            self.currency = value
            
        case .amount:
            self.amount = value
            
        case .tipAndFeeType:
            self.tipAndFeeType = value
            
        case .tipAndFeeAmount:
            self.tipAndFeeAmount = value
            
        case .tipAndFeePercent:
            self.tipAndFeePercent = value
            
        case .nation:
            self.nation = value
            
        case .acquier:
            self.acquier = value
            
        case .city:
            self.city = value
            
        case .zipCode:
            self.zipCode = value
            
        case .additionalData:
            _parseAdditionalInfo(content: nextValue)
            
        case .crc:
            self.crc = value
        }
        
        _parseRoot(content: nextValue)
    }
    
    private
    func _parseProviderInfo(content: String) {
        guard content.count > 4 else { return }
        let (id, value, nextValue) = _slide(content: content)
        let fieldID = VietQRPayField.ProviderFieldID(rawValue: id)
        guard let fieldID = fieldID else {
            _parseProviderInfo(content: String(content[2..<content.count]))
            return
        }
        
        switch fieldID {
        case .guid:
            self.provider.guid = value
        case .consumer:
            let _guid = provider.guid ?? ""
            switch _guid {
            case ProviderKind.VIETQR.guid:
                provider.name = ProviderKind.VIETQR.rawValue
                _parseConsumerInfo(content: value)
            default:
                break
            }
        case .service:
            provider.service = .init(rawValue: value)
        }
        
        _parseProviderInfo(content: nextValue)
    }
    
    private
    func _parseConsumerInfo(content: String) {
        guard content.count > 4 else { return }
        let (id, value, nextValue) = _slide(content: content)
        let fieldID = VietQRPayField.ConsumerField(rawValue: id)
        guard let fieldID = fieldID else {
            _parseConsumerInfo(content: String(content[2..<content.count]))
            return
        }
        
        switch fieldID {
        case .bankBin:
            self.consumer.bankBin = value
            
        case .bankNumber:
            self.consumer.bankNumber = value
        }
        _parseConsumerInfo(content: nextValue)
    }
    
    private
    func _parseAdditionalInfo(content: String) {
        guard content.count > 4 else { return }
        let (id, value, nextValue) = _slide(content: content)
        let fieldID = VietQRPayField.AdditionalDataField(rawValue: id)
        guard let fieldID = fieldID else {
            _parseConsumerInfo(content: String(content[2..<content.count]))
            return
        }
        
        switch fieldID {
        case .billNumber:
            self.additionalData.billNumber = value
            
        case .mobileNumber:
            self.additionalData.mobileNumber = value
            
        case .referenceLabel:
            self.additionalData.reference = value
            
        case .storeLabel:
            self.additionalData.store = value
            
        case .terminalLabel:
            self.additionalData.terminal = value
            
        case .purposeOfTransaction:
            self.additionalData.purpose = value
            
        case .loyaltyNumber:
            self.additionalData.loyaltyNumber = value
            
        case .customerLabel:
            self.additionalData.customerLabel = value
            
        case .additionalConsumerDataRequest:
            self.additionalData.dataRequest = value
        }
        
        _parseAdditionalInfo(content: nextValue)
    }
    
    private
    func _slide(content: String) -> (id: String, value: String, nextValue: String) {
        let id        = String(content[0..<2])
        let length    = Int(content[2..<4]) ?? 0
        let value     = String(content[4..<4+length])
        let nextValue = String(content[4+length..<content.count])
        
        return (id, value, nextValue)
    }
    
    public
    func build() -> String {
        let version    = _genFieldData(id: VietQRPayField.version.rawValue, value: self.version ?? "01")
        let initMethod = _genFieldData(id: VietQRPayField.initMethod.rawValue, value: self.initMethod ?? "11")
        
        var providerDataContent = ""
        let _guid = provider.guid ?? ""
        switch _guid {
        case ProviderKind.VIETQR.guid:
            let bankBin    = _genFieldData(id: VietQRPayField.ConsumerField.bankBin.rawValue, value: self.consumer.bankBin)
            let bankNumber = _genFieldData(id: VietQRPayField.ConsumerField.bankNumber.rawValue, value: self.consumer.bankNumber)
            providerDataContent = bankBin + bankNumber
        default:
            break
        }
        
        let guid          = _genFieldData(id: VietQRPayField.ProviderFieldID.guid.rawValue, value: self.provider.guid)
        let provider      = _genFieldData(id: VietQRPayField.ProviderFieldID.consumer.rawValue, value: providerDataContent)
        let service       = _genFieldData(id: VietQRPayField.ProviderFieldID.service.rawValue, value: self.provider.service?.rawValue)
        let providerValue = guid + provider + service
        let providerData  = _genFieldData(id: self.provider.fieldId, value: providerValue)
        
        let category         = _genFieldData(id: VietQRPayField.category.rawValue, value: self.category)
        let currency         = _genFieldData(id: VietQRPayField.currency.rawValue, value: self.currency ?? "704")
        let amountStr        = _genFieldData(id: VietQRPayField.amount.rawValue, value: self.amount)
        let tipAndFeeType    = _genFieldData(id: VietQRPayField.tipAndFeeType.rawValue, value: self.tipAndFeeType)
        let tipAndFeeAmount  = _genFieldData(id: VietQRPayField.tipAndFeeAmount.rawValue, value: self.tipAndFeeAmount)
        let tipAndFeePercent = _genFieldData(id: VietQRPayField.tipAndFeePercent.rawValue, value: self.tipAndFeePercent)
        let nation           = _genFieldData(id: VietQRPayField.nation.rawValue, value: self.nation ?? "VN")
        let acquier          = _genFieldData(id: VietQRPayField.acquier.rawValue, value: self.acquier)
        let city             = _genFieldData(id: VietQRPayField.city.rawValue, value: self.city)
        let zipCode          = _genFieldData(id: VietQRPayField.zipCode.rawValue, value: self.zipCode)
        
        let billNumber    = _genFieldData(id: VietQRPayField.AdditionalDataField.billNumber.rawValue, value: self.additionalData.billNumber)
        let mobileNumber  = _genFieldData(id: VietQRPayField.AdditionalDataField.mobileNumber.rawValue, value: self.additionalData.mobileNumber)
        let storeLabel    = _genFieldData(id: VietQRPayField.AdditionalDataField.storeLabel.rawValue, value: self.additionalData.store)
        let loyaltyNumber = _genFieldData(id: VietQRPayField.AdditionalDataField.loyaltyNumber.rawValue, value: self.additionalData.loyaltyNumber)
        let reference     = _genFieldData(id: VietQRPayField.AdditionalDataField.referenceLabel.rawValue, value: self.additionalData.reference)
        let customerLabel = _genFieldData(id: VietQRPayField.AdditionalDataField.customerLabel.rawValue, value: self.additionalData.customerLabel)
        let terminal      = _genFieldData(id: VietQRPayField.AdditionalDataField.terminalLabel.rawValue, value: self.additionalData.terminal)
        let purpose       = _genFieldData(id: VietQRPayField.AdditionalDataField.purposeOfTransaction.rawValue, value: self.additionalData.purpose)
        let dataRequest   = _genFieldData(id: VietQRPayField.AdditionalDataField.additionalConsumerDataRequest.rawValue, value: self.additionalData.dataRequest)
        
        let additionalDataContent = [
            billNumber, mobileNumber, storeLabel, loyaltyNumber,
            reference, customerLabel, terminal, purpose, dataRequest,
        ]
            .joined(separator: "")
        let additionalData = _genFieldData(id: VietQRPayField.additionalData.rawValue, value: additionalDataContent)
        
        let preContentQR = [
            version, initMethod, providerData, category,
            currency, amountStr, tipAndFeeType, tipAndFeeAmount,
            tipAndFeePercent, nation, acquier, city, zipCode,
            additionalData, VietQRPayField.crc.rawValue, "04",
        ]
            .joined(separator: "")
        
        let crcCode = _genCRCCode(content: preContentQR)
        let content = preContentQR + crcCode
        return content
    }

    private
    func _genFieldData(id: String?, value: String?) -> String {
        let fieldId = id ?? ""
        let fieldValue = value ?? ""
        guard fieldId.count == 2 && !fieldValue.isEmpty else { return "" }
        let length = {
            let l = "00\(fieldValue.count)"
            return String(l[l.count - 2..<l.count])
        }()
        
        return [fieldId, length, fieldValue].joined(separator: "")
    }
    
    private
    func _genCRCCode(content: String) -> String {
        guard let crcData = content.uppercased().data(using: .ascii) else { return "" }
        let crc16ccitt = CRC16Generator.crc16ccitt(from: crcData)
        let crcCode = "0000\(String(crc16ccitt, radix: 16, uppercase: true))"
        return String(crcCode[crcCode.count - 4..<crcCode.count])
    }
}


fileprivate
extension StringProtocol {
    subscript(range: CountableRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
}
