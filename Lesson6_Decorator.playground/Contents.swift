import Cocoa

protocol Coffee {
    var cost: Double { get }
}

class SimpleCoffee: Coffee {
    var cost: Double {
        return 100.0
    }
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee { get }
    init(base: Coffee)
}

class Milk: CoffeeDecorator {
    var base: Coffee
    required init(base: Coffee) {
        self.base = base
    }
    var cost: Double {
        return base.cost + 30.0
    }
}

class Whip: CoffeeDecorator {
    var base: Coffee
    required init(base: Coffee) {
        self.base = base
    }
    var cost: Double {
        return base.cost + 20.0
    }
}

class Sugar: CoffeeDecorator {
    var base: Coffee
    required init(base: Coffee) {
        self.base = base
    }
    var cost: Double {
        return base.cost - 5.0  // сахар вреден
    }
}

class Cognanc: CoffeeDecorator {
    var base: Coffee
    required init(base: Coffee) {
        self.base = base
    }
    var cost: Double {
        return base.cost + 200.0
    }
}

let coffee = SimpleCoffee()
print("Кофе стоит \(coffee.cost) уе")
let coffeeWithCognac = Cognanc(base: coffee)
print("Кофе с коньяком стоит \(coffeeWithCognac.cost) уе")
let coffeeWithSugar = Sugar(base: coffee)
print("Кофе с сахаром стоит \(coffeeWithSugar.cost) уе")
