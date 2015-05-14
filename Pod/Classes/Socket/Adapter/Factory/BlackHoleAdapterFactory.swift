//
//  BlackHoleAdapterFactory
//  Soca
//
//  Created by Zhuhao Wang on 2/18/15.
//  Copyright (c) 2015 Zhuhao Wang. All rights reserved.
//

import Foundation

class BlackHoleAdapterFactory : AdapterFactory {
    func canHandle(request: ConnectRequest) -> Bool {
        return true
    }
    
    func getAdapter(request: ConnectRequest, delegateQueue: dispatch_queue_t) -> Adapter {
        return BlackHoleAdapter(request: request, delegateQueue: delegateQueue)
    }
}