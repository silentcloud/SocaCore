//
//  ConfigParser.swift
//  Pods
//
//  Created by Zhuhao Wang on 5/24/15.
//
//

import Foundation
import SwiftyJSON

public struct ConfigParser {
    public static func loadProfile(configFilePath: NSURL) -> Profile? {
        if let data = NSData(contentsOfURL: configFilePath) {
            let basePath = configFilePath.URLByDeletingLastPathComponent!
            let configJSON = JSON(data: data)
            let adapters = _parseAdapters(configJSON["adapters"])
            let pacServer = _parsePACServer(configJSON["pac_server"], basePath: basePath)
            let servers = _parseProxies(configJSON["proxies"], adapters: adapters)
            return Profile(proxyServers: servers, pacServer: pacServer)
        } else {
            return nil
        }
    }
    
    private static func _parseAdapters(configJSON: JSON) -> [String: AdapterFactory] {
        var adapters: [String: AdapterFactory] = [:]
        for (index, json) in configJSON {
            var authentication: Authentication?
            if let username = json["username"].string, let password = json["password"].string {
                authentication = Authentication(username: username, password: password)
            }
            let id = json["id"].stringValue
            let host = json["host"].stringValue
            let port = json["port"].intValue
            switch json["type"].stringValue.uppercaseString {
            case "HTTP":
                adapters[id] = HTTPAdapterFactory(host: host, port: port, auth: authentication)
            case "SHTTP":
                adapters[id] = SecureHTTPAdapterFactory(host: host, port: port, auth: authentication)
            case "SOCKS5":
                adapters[id] = SOCKS5AdapterFactory(host: host, port: port)
            case "SHADOWSOCKS":
                let method = ShadowsocksAdapter.EncryptMethod(rawValue: json["method"].stringValue)!
                adapters[id] = ShadowsocksAdapterFacotry(host: host, port: port, password: json["password"].stringValue, method: method)
            default:
                break
            }
        }
        adapters["DIRECT"] = DirectAdapterFactory()
        adapters["BLACKHOLE"] = BlackHoleAdapterFactory()
        return adapters
    }
    
    private static func _parsePACServer(configJSON: JSON, basePath: NSURL) -> PACServer? {
        if let port = configJSON["port"].int, let filePath = configJSON["pac_file"].string {
            let pacPath = NSURL(string: filePath, relativeToURL: basePath)!
            if pacPath.checkResourceIsReachableAndReturnError(nil) {
                return PACServer(listenOnPort: port, withPACFile: pacPath)
            }
        }
        return nil
    }
    
    private static func _parseProxies(configJSON: JSON, adapters: [String: AdapterFactory]) -> [ProxyServer] {
        var servers = [ProxyServer]()
        for (index, json) in configJSON {
            let port = json["port"].intValue
            let ruleManager = _parseRules(json["rules"], adapters: adapters)
            switch json["type"].stringValue.uppercaseString {
            case "HTTP":
                servers.append(HTTPProxyServer(listenOnPort: port, withRuleManager: ruleManager))
            case "SOCKS5":
                servers.append(SOCKS5ProxyServer(listenOnPort: port, withRuleManager: ruleManager))
            default:
                break
            }
        }
        return servers
    }
    
    private static func _parseRules(configJSON: JSON, adapters: [String: AdapterFactory]) -> RuleManager {
        var rules = [Rule]()
        if let json = configJSON.array {
            for ruleJSON in json {
                let adapterFactory = adapters[ruleJSON["adapter"].stringValue]!
                switch ruleJSON["type"].stringValue.uppercaseString {
                case "ALL":
                    rules.append(AllRule(adapterFactory: adapterFactory))
                case "COUNTRY":
                    let country = ruleJSON["params"]["country"].stringValue
                    let match = ruleJSON["params"]["apply"].boolValue
                    rules.append(CountryRule(countryCode: country, match: match, adapterFactory: adapterFactory))
                default:
                    break
                }
            }
        }
        return RuleManager(fromRules: rules, appendDirect: true)
    }
}