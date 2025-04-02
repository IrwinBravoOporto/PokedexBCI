//
//  Endpoints.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import Foundation

public protocol EndpointsProtocols {
    var url: String { get }
    var fileName: String { get }
}

struct BaseUrl {
    static var baseURL = "https://pokeapi.co/api/v2"
}

public enum Endpoints: EndpointsProtocols {
    
    case listPokedex
    
    public var url: String {
        switch self {
        
        case .listPokedex :
            return BaseUrl.baseURL + "/pokemon?"
        }
    
    }
    public var fileName: String {
        return "Fatal Error service \(self.url)"
    }
}
