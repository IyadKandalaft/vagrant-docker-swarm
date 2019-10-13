# Vagrant Docker Swarm

A vagrant development environment to quickly setup a Docker Swarm cluster in a VM environment.

## Getting Started

These instructions will get you going quickly assuming that you meet the prerequisites.

Clone the project locally:

```
git clone https://github.com/IyadKandalaft/vagrant-docker-swarm.git
```

Initialize the Cluster

```
cd vagrant-docker-swarm
vagrant up
```

### Prerequisites

The following software is required on the machine where vagrant is executed.

```
vagrant >= 2.2
ansible >= 2.7
```

Note that ansible v2.7+ is required due to the availability of the docker_swarm module.  Nevertheless, you may be able to manually install the module into previous versions of ansible.

## Built With

* [Vagrant](https://www.vagrantup.com/)
* [Ansible](https://www.ansible.com/)
* [Docker](https://www.docker.com/)

## Customizing Your Swarm

A sample configuration file is provided *config.yml.sample* with working default configuration that will setup multiple masters and workers.  This sample file is copied to *config.yml* if a customized *config.yml* does not exist.

To alter the default configuration, copy *config.yml.sample* to *config.yml* and modify it:

  cp config.yml.sample config.yml
  vim config.yml

### General Options

| Option | Description |
|--------|-------------|
| box | The vagrant box image name to use from Vagrant cloud. |
| cache-packages | Enable or disable host-based caching of installation packages using vagrant-cachier. This speeds up provisioning but is not compatible with all boxes. |

### Swarm Options

Swarm options are divided into manager and worker options but they are generally identical.

| Option | Description |
|--------|-------------|
| host_prefix| Prefix used for the hostname and VM name, which is suffixed by a numeral. e.g. as manager1, manager2, .. |
| count | Number of nodes to spawn.  |
| cpus  | Number of cores to assign per VM. |
| memory | Amount of memory in MB to assign per VM. |

### Networking

Two networks are provisioned: a private network for inter-node communication and a public network for external communication.

| Option | Description |
| nic_type | The provisioner's virtualized hardware driver type.  |
| bridge | Name of the host interface to bridge (use ip link to get dev name).  Leave blank to select on provisioning. |

## Contributing

Fork the project in your own Github namespace
Make changes in the dev branch
Create a pull request
Ensure that your pull request is always up-to-date with new commmits on the dev branch

## Versioning

This project leverages [Semantic Versioning](http://semver.org/) to tag releases. See the available versions by browsing the [tags on this repository](https://github.com/IyadKandalaft/vagrant-docker-swarm/tags). 
## Authors

* **Iyad Kandalaft - *Founding author - [IyadKandalaft](https://github.com/IyadKandalaft)

## License

This project is licensed under the GPLv3 License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

Reserved to acknowledge significant contributions to the code.
