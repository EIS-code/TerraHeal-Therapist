//
//  EditProfile + TextContent.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 26/10/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

enum EditProfileContentType: Int {

    case AccountNumber = 0
    case Name = 1
    case Surname = 2
    case Gender = 3
    case DOB = 4
    case Nif = 5
    case Ssn = 6
    case City = 7
    case Country = 8
    case Phone = 9
    case EmergencyContact = 10
    case Email = 11
    case LanguageSpoken = 12
    case Documents = 13
    case Services = 14
    case Experience = 15
    case Description = 16
    case HealthCodndition = 17
}
//MARK: Placeholder
extension EditProfileContentType {
    func getPlaceHolder() -> String {
        switch self {
        case .AccountNumber:
            return "PROFILE_ACCOUN_NUMBER".localized()
        case .Name:
            return "PROFILE_NAME".localized()
        case .Surname:
            return "PROFILE_SURNAME".localized()
        case .Gender:
            return "PROFILE_GENDER".localized()
        case .DOB:
            return "PROFILE_DOB".localized()
        case .Nif:
            return "PROFILE_NIF".localized()
        case .Ssn:
            return "PROFILE_SSN".localized()
        case .City:
            return "PROFILE_CITY".localized()
        case .Country:
            return "PROFILE_COUNTRY".localized()
        case .Phone:
            return "PROFILE_MOBILE".localized()
        case .EmergencyContact:
            return "PROFILE_EMERGENCY_CONTACT".localized()
        case .Email:
            return "PROFILE_EMAIL".localized()
        case .LanguageSpoken:
            return "PROFILE_LANGUAGE_SPOKEN".localized()
        case .Documents:
            return "PROFILE_MY_DOCUMENTS".localized()
        case .Services:
            return "PROFILE_MY_SERVICES".localized()
        case .Experience:
            return "PROFILE_EXPERIENCE".localized()
        case .Description:
            return "PROFILE_DESCRIPTION".localized()
        case .HealthCodndition:
            return "HEALTH_CONDITION_OR_ALLERGIES".localized()
        }
    }
}
//MARK: Image
extension EditProfileContentType {
    func getImage() -> String {
        switch self {
        case .AccountNumber:
            return ImageAsset.EditProfile.accountNumber
        case .Name:
            return ImageAsset.EditProfile.name
        case .Surname:
            return ImageAsset.EditProfile.surname
        case .Gender:
            return ImageAsset.EditProfile.gender
        case .DOB:
            return ImageAsset.EditProfile.dob
        case .Nif:
            return ImageAsset.EditProfile.nif
        case .Ssn:
            return ImageAsset.EditProfile.ssn
        case .City:
            return ImageAsset.EditProfile.city
        case .Country:
            return ImageAsset.EditProfile.country
        case .Phone:
            return ImageAsset.EditProfile.mobile
        case .EmergencyContact:
            return ImageAsset.EditProfile.emergencyContact
        case .Email:
            return ImageAsset.EditProfile.email
        case .LanguageSpoken:
            return ImageAsset.EditProfile.language
        case .Documents:
            return ImageAsset.EditProfile.document
        case .Services:
            return ImageAsset.EditProfile.services
        case .Experience:
            return ImageAsset.EditProfile.experience
        case .Description:
            return ImageAsset.EditProfile.personalDescription
        case .HealthCodndition:
            return ImageAsset.EditProfile.healthConditions
        }
    }
}
//MARK - Input Configuration

extension EditProfileContentType {
    func getInputConfiguration() -> InputTextFieldDetail {
        switch self {
        case .AccountNumber:
            return InputTextFieldDetail.init()
        case .Name:
            return InputTextFieldDetail.init()
        case .Surname:
            return InputTextFieldDetail.init()
        case .Gender:
            return InputTextFieldDetail.init()
        case .DOB:
            return InputTextFieldDetail.init()
        case .Nif:
            return InputTextFieldDetail.init()
        case .Ssn:
            return InputTextFieldDetail.init()
        case .City:
            return InputTextFieldDetail.init()
        case .Country:
            return InputTextFieldDetail.init()
        case .Phone:
            return InputTextFieldDetail.init()
        case .EmergencyContact:
            return InputTextFieldDetail.init()
        case .Email:
            return InputTextFieldDetail.init()
        case .LanguageSpoken:
            return InputTextFieldDetail.init()
        case .Documents:
            return InputTextFieldDetail.init()
        case .Services:
            return InputTextFieldDetail.init()
        case .Experience:
            return InputTextFieldDetail.init()
        case .Description:
            return InputTextFieldDetail.init()
        case .HealthCodndition:
            return InputTextFieldDetail.init()
        }
    }
}

