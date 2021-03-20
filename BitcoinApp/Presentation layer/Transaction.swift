import Foundation

struct Transaction: Decodable {
    let date: String
    let tid: Int
    let amount: String
    let type: Int
    let price: String
}
