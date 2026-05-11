# CobReport

[![Compile CobReport](https://github.com/ethanKletschke/CobReport/actions/workflows/CompileCobReport.yml/badge.svg)](https://github.com/ethanKletschke/CobReport/actions/workflows/CompileCobReport.yml)

A COBOL app that generates a textfile report from a pre-defined `.dat` file.

- Author: Ethan Kletschke
- Version: `1.0.0`
- Developed on: Windows 11
- License: MIT
- Project Metadata: [project.yaml](./meta/project.yaml)

---

- [CobReport](#cobreport)
  - [How to Use CobReport](#how-to-use-cobreport)
    - [About `Sales.dat`](#about-salesdat)
    - [About `Cities.txt` (If You Clone)](#about-citiestxt-if-you-clone)

---

## How to Use CobReport

### Running the App

1. Decompress the `.zip` folder provided in the repo's latest release
2. Run `CobReport.exe`
3. Open `SalesReport.txt` to view the report.

### Compiling from Source

If you have `cobc` and GnuCOBOL's runtime on your system, you can
clone the app and compile it from source.

This is done by:

1. Cloning the app with `git clone`
2. Navigating into the cloned project folder
3. Navigating into `scripts`
4. Running `build.cmd`

For Linux users, run the following in the project root folder:

```bash
cobc -I ./src -free -x ./src/**.cob -o ./bin/CobReport  -w -q
./bin/CobReport
```

**NOTE**: The app has NOT been tested on Linux. Proceed with caution and make
a GitHub issue for me to fix whatever the problem is.

### About `Sales.dat`

`Sales.dat` is the data file used by CobReport to generate the report file
`SalesReport.txt`. The data within has to follow the format specified below:

| Column    | Content                                                                                      |
|-----------|----------------------------------------------------------------------------------------------|
| 1         | 5-digit sales ID, including leading zeros                                                    |
| Delimiter | 4 spaces                                                                                     |
| 2         | Profit for this quarter. Must be in the format 9999999.99, where "9" is a digit from 0 to 9. |
| Delimiter | 4 spaces                                                                                     |
| 3         | A city name, up to 20 characters                                                             |

### About `Cities.txt` (If You Clone)

When you clone the repository for CobReport, you will notice a `data` folder.
With in the `data` folder is a copy of `Sales.dat`, as well as `Cities.txt`.

`Cities.txt` is merely a note for whoever clones the repository about what cities
were used for the sample data, as well as a note specifying that you can use your
own cities when making your own data. It is not used by the app at runtime.
