import UIKit

func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    return data
}

struct Person: Decodable {
    var name: String?
    var age: Int?
    var isDeveloper: Bool?
}

struct DataPersonResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case data
    }
    let data: [Person]
}

struct ResultPersonResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case result
    }
    let result: [Person]
}

protocol Parseable {
    func parse(data: Data) -> [Person]?
}

// массив
class Parse1: Parseable {
    var next: Parseable?
    func parse(data: Data) -> [Person]? {
        print("try parser1")
        let decoder = JSONDecoder()
        var res: [Person]? = nil
        do {
            res = try decoder.decode([Person].self, from: data)
            if res == nil {
                res = self.next?.parse(data: data)
            }
        } catch {
            res = self.next?.parse(data: data)
        }
        return res
    }}

// ключ result
class Parse2: Parseable {
    var next: Parseable?
    func parse(data: Data) -> [Person]? {
        print("try parser2")
        let decoder = JSONDecoder()
        var res: [Person]? = nil
        do {
            let respResult = try decoder.decode(ResultPersonResponse.self, from: data)
            res = respResult.result
        } catch {
            res = self.next?.parse(data: data)
        }
        return res
    }}

// ключ data
class Parse3: Parseable {
    var next: Parseable?
    func parse(data: Data) -> [Person]? {
        print("try parser3")
        let decoder = JSONDecoder()
        var res: [Person]? = nil
        do {
            let respResult = try decoder.decode(DataPersonResponse.self, from: data)
            res = respResult.data
        } catch {
            res = self.next?.parse(data: data)
        }
        return res
    }}

let data1 = data(from: "1")
let data2 = data(from: "2")
let data3 = data(from: "3")

let p1 = Parse1()
let p2 = Parse2()
let p3 = Parse3()
p1.next = p2
p2.next = p3

let res1 = p1.parse(data: data1)
let res2 = p1.parse(data: data2)
let res3 = p1.parse(data: data3)

print("\(res1!)")
print("\(res2!)")
print("\(res3!)")

