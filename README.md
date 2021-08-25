## Shell script template to start off from

In the book Building Microservices, Sam Newman describes the idea of a golden service template. One that has many best practices in place that can be used for building from when a new project starts.

This is what I use for bash scripts.

## Output of script as is
Running it you will see a log file written to the 'logs' directory containing two log messages with the time stamp, log type 'INFO' and message.
```
# ./logs/main_202010824.log
20210724 17:15:52 - INFO - transform_data run
20210724 17:15:52 - INFO - backup_files run
```
The following is written to the console.
```sh
josh at bash-script-template 🌲 ./main.sh "we stand on the shoulders of giants"
__dir: /Users/joshjohansen/senofjohan/bash-script-template
__file: /Users/joshjohansen/senofjohan/bash-script-template/main.sh
__base: main.sh.sh
__root: /Users/joshjohansen/senofjohan
Add/modify config in main_config.sh
API_FULL_URL sourced: http://127.0.0.1:5000/user
we stand on the shoulders of giants
Logs written to './logs/...'
```


The script 'main.sh' sources the variables form 'main_config.sh' and calls some basic functions. 

Features of 'main.sh' in order of appearance in file
- description
- usage
- set flags such as 'xtrace' for debugging.
- 'magic variables'
- exit codes
- sourcing external script
- create log folders
- main function that receives all parameters
- functions called from main

## Recommended IDE for Shell Scripts
Jetbrains IDEs have the option to install [Shellcheck](https://shellcheck.net) and have it highlight the potential errors as you type. You can install and run shellcheck locally, if for example you are using vim directly on a server.

## Additional Tools

[Shellcheck](https://shellcheck.net) - to find bugs in your shell scripts. 
<br>
[ExplainShell](https://explainshell.com/) - to explain what a line of shell code does.

## Further Research
If you are searching beyond what is found in this repo consider checking out https://bash3boilerplate.sh/ and exploring their main.sh.
They are solving some problems that may be beyond everyones use case, and so I think this is a good starting point.
```
wget http://bash3boilerplate.sh/main.sh
vim main.sh
```
