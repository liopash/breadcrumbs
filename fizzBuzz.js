let fizzer = (x) => x % 15 == 0 ? 'FizzBuzz' : x % 5 == 0 ? 'fizz' : x % 3 == 0 ? 'buzz' : x;

let fizzBuzz = (x) => {
    return [...Array(x).keys()].map( a => fizzer(a));
}

console.log(fizzBuzz(100));
 
module.exports = fizzer;
module.exports = fizzBuzz;
