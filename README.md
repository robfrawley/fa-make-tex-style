
# FontAwesome Latex STY Generator

Quick script to parse the latest icon data from the website and generate a coorosponding STY file for use as a class file
within a Latex project.

## Setup

This project includes a Gemfile; to install the required packages simply run the "bundke" CLI application:

```bash
bundle
```

## Usage

This script only accepts one CLI argument: The file name to output the generated Latex STY class. Calling without any
arguments will result in a STY class file being written to "fontawesome.sty" in the current working directory.

```bash
./fontawesome-make-sty
```

Alternativly, you can customize the output STY class file:

```bash
./fontawesome-make-sty some-other-file-name.sty
```

