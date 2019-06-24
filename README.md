# Status-page

A command-line tool that will pull status information from different services, displays the results and saves it into a data store.

## Installation

Download the docker image

```bash
$ docker pull diogoviana/status-page
```

## Requirements

```bash
$ gem install thor
$ gem install oga
$ gem install rspec
$ gem install time_difference
$ gem install command_line_reporter
```

## Configuration

It is possible to configure the services that will be checked and the inverval(in seconds) of time during the live mode. You can find this file inside config/setup.yml

```yaml
$ services:
    - name: Bitbucket
      address: https://bitbucket.status.atlassian.com/
    - name: Github
      address: https://www.githubstatus.com/
  interval: 5
```

## Usage

### Pull --scope

Pull the status of all services configured in setup.yml. The resuls will both be saved in a CSV file and printed on the screen.

```bash
$ docker run -it diogoviana/status-page status-page pull
```

You can additionally add a scope to pull data only from a specific service. This service should exist inside your setup.yml file.

```bash
$ docker run -it diogoviana/status-page status-page pull github
```

### Live --scope

Pull the status of all services configured in setup.yml continuously. The resuls will both be saved in a CSV file and printed on the screen. This service can be canceled by pressing CTRL + C.

```bash
$ docker run -it diogoviana/status-page status-page live
```

You can additionally add a scope to pull data only from a specific service. This service should exist inside your setup.yml file.

```bash
$ docker run -it diogoviana/status-page status-page live github
```

### History

Display all the data which was gathered by LIVE and PULL modes.

```bash
$ docker run -it diogoviana/status-page status-page history
```

### Stats

Display all the data which was gathered by LIVE and PULL in a summarized way

```bash
$ docker run -it diogoviana/status-page status-page stats
```

### Backup --path

Create a backup file inside the path passed as an argument. You don't need to pass the file name in data argument, only the path. The file will be save as your/path/of/choice/store.csv.bkp

```bash
$ docker run -it diogoviana/status-page status-page backup /usr/local/bkp
```

### Restore --path

Restore and merge the backup file to the current store file. Again, the file name is not needed, only the path which the backup was saved. It is going to look up for a file named store.csv.bkp inside the page you gave as an argument.

```bash
$ docker run -it diogoviana/status-page status-page restore /usr/local/bkp
```
