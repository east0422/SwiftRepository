import Cocoa
import Foundation

class Transaction: Codable {
    var from: String // 交易发起方
    var to: String // 交易接收方
    var amount: Double // 交易金额
    
    init(_ from: String, _ to: String, _ amount: Double) {
        self.from = from;
        self.to = to;
        self.amount = amount;
    }
}

class Block: Codable {
    var index: Int = 0 // 区块序号
    var previousHash: String = "" // 前一个区块的哈希值
    var hash: String! // 当前区块的哈希值
    var nonce: Int // 随机数
    private (set) var transactions: [Transaction] = [Transaction]()
    
    var key: String {
        get {
            let transactionData = try! JSONEncoder().encode(self.transactions)
            let transactionJSONStr = String(data: transactionData, encoding: .utf8)
            
            return String(self.index) + self.previousHash + transactionJSONStr! + String(self.nonce)
        }
    }
    
    init() {
        self.nonce = 0
    }
    
    func addTransaction(_ transaction: Transaction) {
        self.transactions.append(transaction)
    }
}

class Blockchain: Codable {
    private (set) var blocks:[Block] = [Block]()
 
    init() {
        
    }
    
    init(_ genesisBlock: Block) {
        self.addBlock(genesisBlock)
    }
    
    func addBlock(_ block: Block) {
        if self.blocks.isEmpty {
            // 添加创世区块
            // 第一个区块没有 previous hash
            block.previousHash = "0000000000"
        } else {
            let previousBlock = getPreviousBlock()
            block.previousHash = previousBlock.hash
            block.index = self.blocks.count
        }
        
        block.hash = generateHash(for: block)
        self.blocks.append(block)
    }
    
    func getPreviousBlock() -> Block {
        return self.blocks[self.blocks.count - 1]
    }
    
    func getNextBlock(transactions:[Transaction]) -> Block {
        let block = Block()
        transactions.forEach { (transaction) in
            block.addTransaction(transaction)
        }
    
        let previousBlock = getPreviousBlock()
        block.index = self.blocks.count
        block.previousHash = previousBlock.hash
        block.hash = generateHash(for: block)
        
        return block
    }
    
    private func generateHash(for block: Block) -> String {
        var hash = block.key.sha1Hash()
        
        // 设置工作量证明
        while(!hash.hasPrefix("00")) {
            block.nonce += 1
            hash = block.key.sha1Hash()
        }
        
        return hash
    }
    
    
}

extension String {
    func sha1Hash() -> String {
        let task = Process()
        task.launchPath = "/usr/bin/shasum"
        task.arguments = []
        
        let inputPipe = Pipe()
        
        inputPipe.fileHandleForWriting.write(self.data(using: .utf8)!)
        
        inputPipe.fileHandleForWriting.closeFile()
        
        let outputPipe = Pipe()
        task.standardOutput = outputPipe
        task.standardInput = inputPipe
        task.launch()
        
        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let hash = String(data: data, encoding: .utf8)!
        return hash.replacingOccurrences(of: "  -\n", with: "")
    }
}

let transaction1 = Transaction("east", "west", 100)
let block1 = Block()
block1.key

let genesisBlock = Block()
let blockchain = Blockchain(genesisBlock)
let block2 = blockchain.getNextBlock(transactions: [transaction1])
