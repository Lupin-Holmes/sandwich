# Sandwich Attack Generator

This is a simple Ruby script to generate [UUIDs](https://en.wikipedia.org/wiki/Universally_unique_identifier) based on a range of timestamps in order to perform a [Sandwich Attack](https://versprite.com/blog/universally-unique-identifiers/). 

### Usage
The script can be run from terminal with two mandatory parameters and three optional parameters:

**Example:**

```bash
./sandwich.rb <UUID1> <UUID2> [-o <FILEPATH>] [-m "<MACHINE1>,<MACHINE2>,<MACHINE3>"]
```

Parameters:
- `<UUID1>`: First UUID for generating range (required)
- `<UUID2>`: Second UUID for generating range (required)

Optional flags:
- `-o` followed by `<FILEPATH>`: This flag is used to specify an output file name.
- `-m` followed by comma-separated machine names enclosed in quotes. This flag allows you to specify the machines you want to create files for.

If no filename or machine is specified, then will generate in default 'uuids_list.txt' file.

---

### Contributions & Questions
Feel free to contribute if you think there are improvements that can be made to this code. If you have any questions about this repository, please feel free to open an issue.