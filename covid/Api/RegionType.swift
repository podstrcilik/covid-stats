//
//  RegionType.swift
//  covid
//
//  Created by Pavel Odstrčilík on 31.12.2020.
//

import Foundation

public enum RegionType: String, CaseIterable {
    case Praha
    case StredoceskyKraj
    case JihoceskyKraj
    case PlzenskyKraj
    case KarlovarskyKraj
    case UsteckyKraj
    case LibereckyKraj
    case KralovehradeckyKraj
    case PardubickyKraj
    case KrajVysocina
    case JihomoravskyKraj
    case OlomouckyKraj
    case MoravskoslezskyKraj
    case ZlinskyKraj

    var title: String {
        switch self {
        case .Praha:
            return "Hlavní město Praha"
        case .StredoceskyKraj:
            return "Středočeský kraj"
        case .JihoceskyKraj:
            return "Jihočeský kraj"
        case .PlzenskyKraj:
            return "Plzeňský kraj"
        case .KarlovarskyKraj:
            return "Karlovarský kraj"
        case .UsteckyKraj:
            return "Ústecký kraj"
        case .LibereckyKraj:
            return "Liberecký kraj"
        case .KralovehradeckyKraj:
            return "Královéhradecký kraj"
        case .PardubickyKraj:
            return "Pardubický kraj"
        case .KrajVysocina:
            return "Kraj Vysočina "
        case .JihomoravskyKraj:
            return "Jihomoravský kraj"
        case .OlomouckyKraj:
            return "Olomoucký kraj"
        case .MoravskoslezskyKraj:
            return "Moravskoslezský kraj"
        case .ZlinskyKraj:
            return "Zlínský kraj"
        }
    }

    var code: String {
        switch self {
        case .Praha:
            return "CZ010"
        case .StredoceskyKraj:
            return "CZ020"
        case .JihoceskyKraj:
            return "CZ031"
        case .PlzenskyKraj:
            return "CZ032"
        case .KarlovarskyKraj:
            return "CZ041"
        case .UsteckyKraj:
            return "CZ042"
        case .LibereckyKraj:
            return "CZ051"
        case .KralovehradeckyKraj:
            return "CZ052"
        case .PardubickyKraj:
            return "CZ053"
        case .KrajVysocina:
            return "CZ063 "
        case .JihomoravskyKraj:
            return "CZ064"
        case .OlomouckyKraj:
            return "CZ071"
        case .MoravskoslezskyKraj:
            return "CZ080"
        case .ZlinskyKraj:
            return "CZ072"
        }
    }
}
