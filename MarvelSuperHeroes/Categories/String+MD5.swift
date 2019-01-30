//
//  String+MD5.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 26/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {

    func MD5() -> String? {
        
        if let messageData = self.data(using:.utf8) {

            var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

            _ = digestData.withUnsafeMutableBytes {digestBytes in

                messageData.withUnsafeBytes {messageBytes in

                    CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
                }
            }

            return digestData.map { String(format: "%02hhx", $0) }.joined()
        }

        return nil
    }
}
