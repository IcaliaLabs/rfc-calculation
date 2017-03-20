# rfc-calculation

`rfc-calculation` is a JavaScript dependency for calculating mexican RFC.

## Version
0.1.0

## Instalation

```console
 npm install rfc-calculation
```

## Usage

To calculate a RFC you'll need to provide the following parameters:

- Name
- Paternal Lastname
- Maternal Lastname
- Birthdate

```
var rfc = require('rfc-calculation')

let name = "Alejandro"
let pLname = "Gutierrez"
let mLname = "Sanchez"
let bDate = "1990-04-28"

let result = new rfc(name, pLname, mLname, bDate)
console.log(result.rfc)
```

And that's it! Just make sure that your date is formatted like so: ```
YYYY-MM-DD ``` and you'll have your RFC.

## Credits
[BanregioLABS](https://github.com/banregiolabs)

## License
MIT License

Copyright (c) 2017 Icalia Labs

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.