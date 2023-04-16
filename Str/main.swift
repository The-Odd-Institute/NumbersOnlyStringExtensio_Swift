import Foundation




extension String
{
    // takes: 1 s, 549 ms, 541 µs, 375 ns
    func characterMethod () -> String {
        var output = ""
        for char in self {
            if char.isNumber {
                output += String(char)
                // output.append(char) // -> Would be idential
            }
        }
        return output
    }
    
    // takes: 7 s, 394 ms, 747 µs, 834 ns
    func splitMethod () -> String {
        let cSet = NSCharacterSet(charactersIn: "0123456789")
        let reversed = cSet.inverted
        let separated = self.components(separatedBy: reversed)
        return separated.joined(separator: "")
    }
    
    // takes: 1 s, 582 ms, 825 µs, 250 ns
    func filterMethod () -> String {
        return self.filter { $0.isNumber }
    }
}




// Running either of the options for 1_000_000 rounds

var myString: String = "skeyncotw8nhfcn7w8tyaelvg7oi7tr"


func charWay () {
    for _ in 0..<1_000_000 {
        let _ = myString.characterMethod()
    }
}

func splitWay () {
    for _ in 0..<1_000_000 {
        let _ = myString.splitMethod()
    }
}

func filterWay () {
    for _ in 0..<1_000_000 {
        let _ = myString.filterMethod()
    }
}







// Timing the function

func timeit( body: () -> () ) -> UInt64
{
    let t1 = DispatchTime.now().uptimeNanoseconds
    body()
    let t2 = DispatchTime.now().uptimeNanoseconds
    return t2-t1
}



// Formatting from nanoeconds to sec/milli/micro/nano

func timeFormatter (subNanos: UInt64) -> String
{
    let secs = subNanos / 1_000_000_000
    let mils = (subNanos % 1_000_000_000) / 1_000_000
    let mics = (subNanos % 1_000_000) / 1_000
    let nans = subNanos % 1_000

    let format = "%d s, %d ms, %d µs, %d ns"
    
    return String(format: format, secs, mils, mics, nans)
}























let t1_nanons = timeit(body: charWay)
let t2_nanons = timeit(body: splitWay)
let t3_nanons = timeit(body: filterWay)

let t1_formatted = timeFormatter(subNanos: t1_nanons)
let t2_formatted = timeFormatter(subNanos: t2_nanons)
let t3_formatted = timeFormatter(subNanos: t3_nanons)


print ("Char way takes: " + t1_formatted)
print ("Split way takes: " + t2_formatted)
print ("Filter way takes: " + t3_formatted)

