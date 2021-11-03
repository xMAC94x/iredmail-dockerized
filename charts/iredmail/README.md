# iRedMail

With [iRedMail](https://iredmail.org/), you can deploy an OPEN SOURCE, FULLY FLEDGED, FULL-FEATURED mail server in several minutes, for free.

## TL;DR;

```console
helm repo add nextcloud https://nextcloud.github.io/helm/
helm install my-release nextcloud/nextcloud
```

## Introduction

This chart bootstraps an [iredmail](https://github.com/iredmail/dockerized) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

The iredmail docker image packages its own dependencies like mariadb database already inside the docker image.

## Prerequisites

- Kubernetes 1.9+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add nextcloud https://nextcloud.github.io/helm/
helm install my-release nextcloud/nextcloud
```

The command deploys nextcloud on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the nextcloud chart and their default values.

| Parameter                                                    | Description                                             | Default                                     |
| ------------------------------------------------------------ | ------------------------------------------------------- | ------------------------------------------- |
| `image.repository`                                           | nextcloud Image name                                    | `nextcloud`                                 |
| `image.tag`                                                  | nextcloud Image tag                                     | `{VERSION}`                                 |
| `image.pullPolicy`                                           | Image pull policy                                       | `IfNotPresent`                              |
| `image.pullSecrets`                                          | Specify image pull secrets                              | `nil`                                       |
| `ingress.className`                                          | Name of the ingress class to use                        | `nil`                                       |
| `ingress.enabled`                                            | Enable use of ingress controllers                       | `false`                                     |
| `ingress.servicePort`                                        | Ingress' backend servicePort                            | `http`                                      |
| `ingress.annotations`                                        | An array of service annotations                         | `nil`                                       |
| `ingress.labels`                                             | An array of service labels                              | `nil`                                       |
| `ingress.path`                                               | The `Path` to use in Ingress' `paths`                   | `/`                                         |
| `ingress.pathType`                                           | The `PathType` to use in Ingress' `paths`               | `Prefix`                                    |
| `ingress.tls`                                                | Ingress TLS configuration                               | `[]`                                        |
| `nextcloud.host`                                             | nextcloud host to create application URLs               | `nextcloud.kube.home`                       |
| `nextcloud.username`                                         | User of the application                                 | `admin`                                     |
| `nextcloud.password`                                         | Application password                                    | `changeme`                                  |
| `nextcloud.existingSecret.enabled`                           | Whether to use an existing secret or not                | `false`                                     |
| `nextcloud.existingSecret.secretName`                        | Name of the existing secret                             | `nil`                                       |
| `nextcloud.existingSecret.usernameKey`                       | Name of the key that contains the username              | `nil`                                       |
| `nextcloud.existingSecret.passwordKey`                       | Name of the key that contains the password              | `nil`                                       |
| `nextcloud.existingSecret.smtpUsernameKey`                   | Name of the key that contains the SMTP username         | `nil`                                       |
| `nextcloud.existingSecret.smtpPasswordKey`                   | Name of the key that contains the SMTP password         | `nil`                                       |
| `nextcloud.update`                                           | Trigger update if custom command is used                | `0`                                         |
| `nextcloud.containerPort`                                    | Customize container port when not running as root       | `80`                                        |
| `nextcloud.datadir`                                          | nextcloud data dir location                             | `/var/www/html/data`                        |
| `nextcloud.mail.enabled`                                     | Whether to enable/disable email settings                | `false`                                     |
| `nextcloud.mail.fromAddress`                                 | nextcloud mail send from field                          | `nil`                                       |
| `nextcloud.mail.domain`                                      | nextcloud mail domain                                   | `nil`                                       |
| `nextcloud.mail.smtp.host`                                   | SMTP hostname                                           | `nil`                                       |
| `nextcloud.mail.smtp.secure`                                 | SMTP connection `ssl` or empty                          | `''`                                        |
| `nextcloud.mail.smtp.port`                                   | Optional SMTP port                                      | `nil`                                       |
| `nextcloud.mail.smtp.authtype`                               | SMTP authentication method                              | `LOGIN`                                     |
| `nextcloud.mail.smtp.name`                                   | SMTP username                                           | `''`                                        |
| `nextcloud.mail.smtp.password`                               | SMTP password                                           | `''`                                        |
| `nextcloud.configs`                                          | Config files created in `/var/www/html/config`          | `{}`                                        |
| `nextcloud.persistence.subPath`                              | Set the subPath for nextcloud to use in volume          | `nil`                                       |
| `nextcloud.phpConfigs`                                       | PHP Config files created in `/usr/local/etc/php/conf.d` | `{}`                                        |
| `nextcloud.defaultConfigs.\.htaccess`                        | Default .htaccess to protect `/var/www/html/config`     | `true`                                      |
| `nextcloud.defaultConfigs.redis\.config\.php`                | Default Redis configuration                             | `true`                                      |
| `nextcloud.defaultConfigs.apache-pretty-urls\.config\.php`   | Default Apache configuration for rewrite urls           | `true`                                      |
| `nextcloud.defaultConfigs.apcu\.config\.php`                 | Default configuration to define APCu as local cache     | `true`                                      |
| `nextcloud.defaultConfigs.apps\.config\.php`                 | Default configuration for apps                          | `true`                                      |
| `nextcloud.defaultConfigs.autoconfig\.php`                   | Default auto-configuration for databases                | `true`                                      |
| `nextcloud.defaultConfigs.smtp\.config\.php`                 | Default configuration for smtp                          | `true`                                      |
| `nextcloud.strategy`                                         | specifies the strategy used to replace old Pods by new ones | `type: Recreate`                        |
| `nextcloud.extraEnv`                                         | specify additional environment variables                | `{}`                                        |
| `nextcloud.extraVolumes`                                     | specify additional volumes for the NextCloud pod        | `{}`                                        |
| `nextcloud.extraVolumeMounts`                                | specify additional volume mounts for the NextCloud pod  | `{}`                                        |
| `nginx.enabled`                                              | Enable nginx (requires you use php-fpm image)           | `false`                                     |
| `nginx.image.repository`                                     | nginx Image name                                        | `nginx`                                     |
| `nginx.image.tag`                                            | nginx Image tag                                         | `alpine`                                    |
| `nginx.image.pullPolicy`                                     | nginx Image pull policy                                 | `IfNotPresent`                              |
| `nginx.config.default`                                       | Whether to use nextclouds recommended nginx config      | `true`                                      |
| `nginx.config.custom`                                        | Specify a custom config for nginx                       | `{}`                                        |
| `nginx.resources`                                            | nginx resources                                         | `{}`                                        |
| `lifecycle.postStartCommand`                                 | Specify deployment lifecycle hook postStartCommand      | `nil`                                       |
| `lifecycle.preStopCommand`                                   | Specify deployment lifecycle hook preStopCommand        | `nil`                                       |
| `internalDatabase.enabled`                                   | Whether to use internal sqlite database                 | `true`                                      |
| `internalDatabase.database`                                  | Name of the existing database                           | `nextcloud`                                 |
| `externalDatabase.enabled`                                   | Whether to use external database                        | `false`                                     |
| `externalDatabase.type`                                      | External database type: `mysql`, `postgresql`           | `mysql`                                     |
| `externalDatabase.host`                                      | Host of the external database in form of `host:port`    | `nil`                                       |
| `externalDatabase.database`                                  | Name of the existing database                           | `nextcloud`                                 |
| `externalDatabase.user`                                      | Existing username in the external db                    | `nextcloud`                                 |
| `externalDatabase.password`                                  | Password for the above username                         | `nil`                                       |
| `externalDatabase.existingSecret.enabled`                    | Whether to use a existing secret or not                 | `false`                                     |
| `externalDatabase.existingSecret.secretName`                 | Name of the existing secret                             | `nil`                                       |
| `externalDatabase.existingSecret.usernameKey`                | Name of the key that contains the username              | `nil`                                       |
| `externalDatabase.existingSecret.passwordKey`                | Name of the key that contains the password              | `nil`                                       |
| `mariadb.enabled`                                            | Whether to use the MariaDB chart                        | `false`                                     |
| `mariadb.auth.database`                                      | Database name to create                                 | `nextcloud`                                 |
| `mariadb.auth.password`                                      | Password for the database                               | `changeme`                                  |
| `mariadb.auth.username`                                      | Database user to create                                 | `nextcloud`                                 |
| `mariadb.auth.rootPassword`                                  | MariaDB admin password                                  | `nil`                                       |
| `redis.enabled`                                              | Whether to install/use redis for locking                | `false`                                     |
| `redis.usePassword`                                          | Whether to use a password with redis                    | `false`                                     |
| `redis.password`                                             | The password redis uses                                 | `''`                                        |
| `cronjob.enabled`                                            | Whether to enable/disable cronjob                       | `false`                                     |
| `cronjob.schedule`                                           | Schedule for the CronJob                                | `*/15 * * * *`                              |
| `cronjob.annotations`                                        | Annotations to add to the cronjob                       | {}                                          |
| `cronjob.curlInsecure`                                       | Set insecure (-k) option to curl                        | false                                       |
| `cronjob.failedJobsHistoryLimit`                             | Specify the number of failed Jobs to keep               | `5`                                         |
| `cronjob.successfulJobsHistoryLimit`                         | Specify the number of completed Jobs to keep            | `2`                                         |
| `cronjob.resources`                                          | Cronjob Resources                                       | `nil`                                       |
| `cronjob.nodeSelector`                                       | Cronjob Node selector                                   | `nil`                                       |
| `cronjob.tolerations`                                        | Cronjob tolerations                                     | `nil`                                       |
| `cronjob.affinity`                                           | Cronjob affinity                                        | `nil`                                       |
| `service.type`                                               | Kubernetes Service type                                 | `ClusterIP`                                 |
| `service.loadBalancerIP`                                     | LoadBalancerIp for service type LoadBalancer            | `nil`                                       |
| `service.nodePort`                                           | NodePort for service type NodePort                      | `nil`                                       |
| `persistence.enabled`                                        | Enable persistence using PVC                            | `false`                                     |
| `persistence.annotations`                                    | PVC annotations                                         | `{}`                                        |
| `persistence.storageClass`                                   | PVC Storage Class for nextcloud volume                  | `nil` (uses alpha storage class annotation) |
| `persistence.existingClaim`                                  | An Existing PVC name for nextcloud volume               | `nil` (uses alpha storage class annotation) |
| `persistence.accessMode`                                     | PVC Access Mode for nextcloud volume                    | `ReadWriteOnce`                             |
| `persistence.size`                                           | PVC Storage Request for nextcloud volume                | `8Gi`                                       |
| `resources`                                                  | CPU/Memory resource requests/limits                     | `{}`                                        |
| `rbac.enabled`                                               | Enable Role and rolebinding for priveledged PSP         | `false`                                     |
| `rbac.serviceaccount.create`                                 | Wether to create a serviceaccount or use an existing one (requires rbac) | `true`                     |
| `rbac.serviceaccount.name`                                   | The name of the sevice account that the deployment will use (requires rbac) | `nextcloud-serviceaccount` |
| `livenessProbe.enabled`                                      | Turn on and off liveness probe                          | `true`                                      |
| `livenessProbe.initialDelaySeconds`                          | Delay before liveness probe is initiated                | `10`                                        |
| `livenessProbe.periodSeconds`                                | How often to perform the probe                          | `10`                                        |
| `livenessProbe.timeoutSeconds`                               | When the probe times out                                | `5`                                         |
| `livenessProbe.failureThreshold`                             | Minimum consecutive failures for the probe              | `3`                                         |
| `livenessProbe.successThreshold`                             | Minimum consecutive successes for the probe             | `1`                                         |
| `readinessProbe.enabled`                                     | Turn on and off readiness probe                         | `true`                                      |
| `readinessProbe.initialDelaySeconds`                         | Delay before readiness probe is initiated               | `10`                                        |
| `readinessProbe.periodSeconds`                               | How often to perform the probe                          | `10`                                        |
| `readinessProbe.timeoutSeconds`                              | When the probe times out                                | `5`                                         |
| `readinessProbe.failureThreshold`                            | Minimum consecutive failures for the probe              | `3`                                         |
| `readinessProbe.successThreshold`                            | Minimum consecutive successes for the probe             | `1`                                         |
| `startupProbe.enabled`                                       | Turn on and off startup probe                           | `false`                                     |
| `startupProbe.initialDelaySeconds`                           | Delay before readiness probe is initiated               | `30`                                        |
| `startupProbe.periodSeconds`                                 | How often to perform the probe                          | `10`                                        |
| `startupProbe.timeoutSeconds`                                | When the probe times out                                | `5`                                         |
| `startupProbe.failureThreshold`                              | Minimum consecutive failures for the probe              | `30`                                        |
| `startupProbe.successThreshold`                              | Minimum consecutive successes for the probe             | `1`                                         |
| `hpa.enabled`                                                | Boolean to create a HorizontalPodAutoscaler             | `false`                                     |
| `hpa.cputhreshold`                                           | CPU threshold percent for the HorizontalPodAutoscale    | `60`                                        |
| `hpa.minPods`                                                | Min. pods for the Nextcloud HorizontalPodAutoscaler     | `1`                                         |
| `hpa.maxPods`                                                | Max. pods for the Nextcloud HorizontalPodAutoscaler     | `10`                                        |
| `deploymentLabels`                                           | Labels to be added at 'deployment' level                | not set                                     |
| `deploymentAnnotations`                                      | Annotations to be added at 'deployment' level           | not set                                     |
| `podLabels`                                                  | Labels to be added at 'pod' level                       | not set                                     |
| `podAnnotations`                                             | Annotations to be added at 'pod' level                  | not set                                     |
| `metrics.enabled`                                            | Start Prometheus metrics exporter                       | `false`                                     |
| `metrics.https`                                              | Defines if https is used to connect to nextcloud        | `false` (uses http)                         |
| `metrics.timeout`                                            | When the scrape times out                               | `5s`                                        |
| `metrics.image.repository`                                   | Nextcloud metrics exporter image name                   | `xperimental/nextcloud-exporter`            |
| `metrics.image.tag`                                          | Nextcloud metrics exporter image tag                    | `v0.3.0`                                    |
| `metrics.image.pullPolicy`                                   | Nextcloud metrics exporter image pull policy            | `IfNotPresent`                              |
| `metrics.podAnnotations`                                     | Additional annotations for metrics exporter             | not set                                     |
| `metrics.podLabels`                                          | Additional labels for metrics exporter                  | not set                                     |
| `metrics.service.type`                                       | Metrics: Kubernetes Service type                        | `ClusterIP`                                 |
| `metrics.service.loadBalancerIP`                             | Metrics: LoadBalancerIp for service type LoadBalancer   | `nil`                                       |
| `metrics.service.nodePort`                                   | Metrics: NodePort for service type NodePort             | `nil`                                       |
| `metrics.service.annotations`                                | Additional annotations for service metrics exporter     | `{prometheus.io/scrape: "true", prometheus.io/port: "9205"}` |
| `metrics.service.labels`                                     | Additional labels for service metrics exporter          | `{}`                                        |

> **Note**:
>
> For nextcloud to function correctly, you should specify the `nextcloud.host` parameter to specify the FQDN (recommended) or the public IP address of the nextcloud service.
>
> Optionally, you can specify the `service.loadBalancerIP` parameter to assign a reserved IP address to the nextcloud service of the chart. However please note that this feature is only available on a few cloud providers (f.e. GKE).
>
> To reserve a public IP address on GKE:
>
> ```bash
> gcloud compute addresses create nextcloud-public-ip
> ```
>
> The reserved IP address can be associated to the nextcloud service by specifying it as the value of the `service.loadBalancerIP` parameter while installing the chart.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm install --name my-release \
  --set nextcloud.username=admin,nextcloud.password=password,mariadb.auth.rootPassword=secretpassword \
    nextcloud/nextcloud
```

The above command sets the nextcloud administrator account username and password to `admin` and `password` respectively. Additionally, it sets the MariaDB `root` user password to `secretpassword`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
helm install --name my-release -f values.yaml nextcloud/nextcloud
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Persistence

The [Nextcloud](https://hub.docker.com/_/nextcloud/) image stores the nextcloud data and configurations at the `/var/www/html` paths of the container.

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, and minikube.
See the [Configuration](#configuration) section to enable persistence and configuration of the PVC.
