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

protocol PersonParseable {
    func parse(data: Data) -> [Person]?
}

// массив
class ParserArray: PersonParseable {
    var next: PersonParseable?
    func parse(data: Data) -> [Person]? {
        print("try ParserArray")
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
class ParserKeyResult: PersonParseable {
    var next: PersonParseable?
    func parse(data: Data) -> [Person]? {
        print("try ParserKeyResult")
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
class ParserKeyData: PersonParseable {
    var next: PersonParseable?
    func parse(data: Data) -> [Person]? {
        print("try ParserKeyData")
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

func ParseData(data: Data) -> [Person]? {
    let p1 = ParserArray()
    let p2 = ParserKeyResult()
    let p3 = ParserKeyData()
    p1.next = p2
    p2.next = p3
    let persons = p1.parse(data: data)
    if let pp = persons {
        for p in pp {
            let status = (p.isDeveloper ?? false) ? "developer:-(" : "not developer"
            print("Person \(p.name ?? ""): age \(p.age ?? 0) \(status)")
        }
    }
    return persons
}

var persons = ParseData(data: data1)
persons = ParseData(data: data2)
persons = ParseData(data: data3)

