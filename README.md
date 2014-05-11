#git-sync
Watch and synchronize one file via git.

## Usage
    sync.sh /path/to/file [push_timeout [pull_timeout [commit_message]]]
    
`push_timeout` - interval in seconds between file modification checks.

`pull_timeout` - interval between executing `git pull` command at directory of specified file.

`commit_message` will be used as comment for synchronization commits.

If specified file does not exists - script will continue to watch until the file appears.

### Example
    sync.sh ~/git/repo/sample.txt 10 30 "Sample file changed" > ~/gitsync.log &
`~/git/repo` folder must be git repository with specified origin. Local changes will be checked every 10 seconds, `git pull` will be executed every 30 seconds.
    
### LSB init script
For debian-based systems there is usefull script which could wrap our utility into service: [jasonblewis/sample-service-script](https://github.com/jasonblewis/sample-service-script)
