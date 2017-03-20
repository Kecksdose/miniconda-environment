[![Build Status](https://travis-ci.org/Kecksdose/miniconda-environment.svg?branch=master)](https://travis-ci.org/Kecksdose/miniconda-environment)

### Basic configuration (on CentOS `/lib/systemd/system/jupyterhub.service`)

```
    [Unit]
    Description=Jupyterhub
    After=network-online.target

    [Service]
    User=root
    Environment=PATH=/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/opt/miniconda/envs/jupyterhub/bin
    ExecStart=/opt/miniconda/envs/jupyterhub/bin/jupyterhub --port 80
    WorkingDirectory=/etc/jupyterhub

    [Install]
    WantedBy=multi-user.target
```
