//
//  Model.swift
//  Countries
//
//  Created by Roy Orpiano on 11/8/21.
//

import Foundation

struct Flag: Codable, Hashable {
    let svg: String
    let png: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(svg)
        hasher.combine(png)
    }
}

struct Currency: Codable, Hashable {
    let code: String
    let name: String
    let symbol: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
        hasher.combine(name)
        hasher.combine(symbol)
    }
}

struct Language: Codable, Hashable {
    let iso639_1: String?
    let iso639_2: String?
    let name: String?
    let nativeName: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(iso639_1)
        hasher.combine(iso639_2)
        hasher.combine(name)
        hasher.combine(nativeName)
    }
}

struct Translation: Codable, Hashable {
    let br: String
    let pt: String
    let nl: String
    let hr: String
    let fa: String
    let de: String
    let es: String
    let fr: String
    let ja: String
    let it: String
    let hu: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(br)
        hasher.combine(pt)
        hasher.combine(nl)
        hasher.combine(hr)
        hasher.combine(fa)
        hasher.combine(de)
        hasher.combine(es)
        hasher.combine(fr)
        hasher.combine(ja)
        hasher.combine(it)
        hasher.combine(hu)
    }
}

struct RegionalBloc: Codable, Hashable {
    let acronym: String
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(acronym)
        hasher.combine(name)
    }
}

struct Country: Codable, Hashable {
    let name: String
//    let topLevelDomain: [String]?
//    let alpha2Code: String?
//    let alpha3Code: String?
//    let callingCodes: [String]?
    let capital: String?
//    let altSpellings: [String]?
//    let subregion: String?
//    let region: String?
//    let population: Int64?
//    let latlng: [CFloat]?
//    let demonym: String?
//    let area: Double?
//    let gini: Double?
//    let timezones: [String]?
//    let borders: [String]?
//    let nativeName: String?
//    let numericCode: String?
    let flags: Flag
    let currencies: [Currency]?
    let languages: [Language]?
//    let translations: [Translation]?
    let flag: String
//    let regionalBlocs: [RegionalBloc]?
//    let cioc: String?
//    let independent: Bool?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
//        hasher.combine(topLevelDomain)
//        hasher.combine(alpha2Code)
//        hasher.combine(alpha3Code)
//        hasher.combine(callingCodes)
        hasher.combine(capital)
//        hasher.combine(altSpellings)
//        hasher.combine(subregion)
//        hasher.combine(region)
//        hasher.combine(population)
//        hasher.combine(latlng)
//        hasher.combine(demonym)
//        hasher.combine(area)
//        hasher.combine(gini)
//        hasher.combine(timezones)
//        hasher.combine(borders)
//        hasher.combine(nativeName)
//        hasher.combine(numericCode)
        hasher.combine(flags)
//        hasher.combine(currencies)
//        hasher.combine(languages)
//        hasher.combine(translations)
        hasher.combine(flag)
//        hasher.combine(regionalBlocs)
//        hasher.combine(cioc)
//        hasher.combine(independent)
    }
}
