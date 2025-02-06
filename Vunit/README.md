https://vunit.github.io/

#### 0. python3 run.py

#### 1. -q, --quiet
Do not print test output even in the case of failure. <br/>
`python3 run.py -q`

#### 2. -g, --gui
`python3 run.py -g`

#### 3. -f, --files
Only list all files in compile order. <br/>
`python3 run.py -f`

Result: <br/>
```bash
tb_lib, test.vhdl
tb_lib, design.vhdl
Listed 2 files
```

#### 4. -l, --list
Only list all test cases. <br/>
`python3 run.py -l`

Result: <br/>
```bash
tb_lib.tb_example.test_case_name
tb_lib.tb_example.test_case_name2
tb_lib.tb_example.test_case_name3
tb_lib.tb_example.test_case_name4
Listed 4 tests
```

#### 5. Run a specific test case.
`python3 run.py tb_lib.tb_example.test_case_name`
