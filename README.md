# Status-page
A command-line tool that will pull status information from different services, displays the results and saves it into a data store.

# Installation
Download the docker image

```bash
$ docker pull diogoviana/status-page
```

Or clone this repository:

```bash
$ git clone git@github.com:kiromba/status-page.git
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

