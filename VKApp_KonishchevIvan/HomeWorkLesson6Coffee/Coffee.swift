//
//  Coffee.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 29.08.2022.
//

import Foundation

protocol Coffee {
    var coast: Int {get}
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee {get}
    init(base: Coffee)
}
// простой кофе
final class SimpleCoffee: Coffee {
    
    var coast: Int {
        return 10
    }
}
// кофе с молоком
final class CoffeeMilk: CoffeeDecorator {
    var base: Coffee
    
    init(base: Coffee) {
        self.base = base

    }
    
    var coast: Int {
        return base.coast + 20
    }
}
// кофе со взбитыми сливками
final class CoffeeWhip: CoffeeDecorator {
    var base: Coffee
    
    init(base: Coffee) {
        self.base = base

    }
    
    var coast: Int {
        return base.coast + 40
    }
}


//кофе с сахаром
final class CoffeeSugar: CoffeeDecorator {
    var base: Coffee
    
    init(base: Coffee) {
        self.base = base

    }
    
    var coast: Int {
        return base.coast + 50
    }
}

// результат//
let coffee = SimpleCoffee()
let coffeeMilk = CoffeeMilk(base: coffee)
let coffeeMilkAndSugar = CoffeeSugar(base: coffeeMilk)
let coffeeFull = CoffeeWhip(base: coffeeMilkAndSugar)

