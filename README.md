BOSH release to run influxdb
=======================
This repository contain Idefixdb BOSH release.

Background
----------

### What is Influxdb?

>"InfluxDB is an open source database written in Go specifically to handle time series data with high availability and high performance requirements. InfluxDB installs in minutes without external dependencies, yet is flexible and scalable enough for complex deployments."

>https://www.influxdata.com/

Usage
-----

To use this bosh release, first upload it to your bosh:

```
bosh upload release https://github.com/hybris/influxdb-boshrelease
```

For [bosh-lite](https://github.com/cloudfoundry/bosh-lite), you can quickly create a deployment manifest & deploy a cluster:

```
templates/make_manifest warden
bosh -n deploy
```

### Override security groups

For AWS & Openstack, the default deployment assumes there is a `default` security group. If you wish to use a different security group(s) then you can pass in additional configuration when running `make_manifest` above.

Create a file `my-networking.yml`:

```yaml
---
networks:
  - name: influxdb
    type: dynamic
    cloud_properties:
      security_groups:
        - influxenterprise
```

Where `- influxdb` means you wish to use an existing security group called `influxdb`.

You now suffix this file path to the `make_manifest` command:

```
templates/make_manifest warden my-networking.yml
bosh -n deploy
```
