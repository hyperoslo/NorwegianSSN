#NorwegianSSN

A convenient way of validating and extracting info from a Norwegian Social Security Number

Reference http://www.kith.no/upload/5588/KITH1001-2010_Identifikatorer-for-personer_v1.pdf

``` objc
let ssn = NorwegianSSN.init(ssn:"xxxxxxxxxxx")

if ssn.isValid() {
    NSLog(@"Yeap, this is valid alright, tell me more about this so called person.")
    self.gainInterest = true
}

if ssn.isDNumber() {
    println("OMG! A potential swede")
    self.runAndHide()
}

if !ssn.isMale() {
    println("Oh, it's a woman!")
    self.comesBack()
}

println("Are you sure? Remember what happened last time?")

if ssn.isFemale() {
    println("Yeah I'm sure, this is not an Aerosmith song!")
    self.startWhistlingOnTune("Aerosmith -  Dude (looks like a lady")
    println("Doh!")
}

if ssn.age() >= 18 && ssn.age() < 35 {
    println("Dear diary, jackpot")
    self.enableTheSmoulder = true
}

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

[Hyper](http://hyper.no) made this. We're a digital communications agency with a passion for good code,
and if you're using this library we probably want to hire you.

## License

NorwegianSSN is available under the MIT license. See the [LICENSE](https://github.com/hyperoslo/NorwegianSSN/raw/develop/LICENSE.md) file for more info.
