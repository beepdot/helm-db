<!--- app-name: PostgreSQL -->

# PostgreSQL

PostgreSQL (Postgres) is an open source object-relational database known for reliability and data integrity. ACID-compliant, it supports foreign keys, joins, views, triggers and stored procedures.

[Overview of PostgreSQL](http://www.postgresql.org)

                           
```bash
helm repo add db https://keshavprasadms.github.io/helm-db
helm install my-release postgresql
```

## Introduction

This chart bootstraps a [PostgreSQL](https://github.com/bitnami/bitnami-docker-postgresql) deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

For HA, please see [this repo](https://github.com/bitnami/charts/tree/master/bitnami/postgresql-ha)

Bitnami charts can be used with [Kubeapps](https://kubeapps.com/) for deployment and management of Helm Charts in clusters. This chart has been tested to work with NGINX Ingress, cert-manager, fluentd and Prometheus on top of the [BKPR](https://kubeprod.io/).

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release bitnami/postgresql
```

The command deploys PostgreSQL on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components but PVC's associated with the chart and deletes the release.

To delete the PVC's associated with `my-release`:

```bash
kubectl delete pvc -l release=my-release
```

> **Note**: Deleting the PVC's will delete postgresql data as well. Please be cautious before doing it.

## Parameters

### Global parameters

| Name                                         | Description                                                                                 | Value |
| -------------------------------------------- | ------------------------------------------------------------------------------------------- | ----- |
| `global.imageRegistry`                       | Global Docker image registry                                                                | `""`  |
| `global.imagePullSecrets`                    | Global Docker registry secret names as an array                                             | `[]`  |
| `global.storageClass`                        | Global StorageClass for Persistent Volume(s)                                                | `""`  |
| `global.postgresql.auth.postgresPassword`    | Password for the "postgres" admin user (overrides `auth.postgresPassword`)                  | `""`  |
| `global.postgresql.auth.username`            | Name for a custom user to create (overrides `auth.username`)                                | `""`  |
| `global.postgresql.auth.password`            | Password for the custom user to create (overrides `auth.password`)                          | `""`  |
| `global.postgresql.auth.database`            | Name for a custom database to create (overrides `auth.database`)                            | `""`  |
| `global.postgresql.auth.existingSecret`      | Name of existing secret to use for PostgreSQL credentials (overrides `auth.existingSecret`) | `""`  |
| `global.postgresql.service.ports.postgresql` | PostgreSQL service port (overrides `service.ports.ˀpostgresql`)                              | `""`  |


### Common parameters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| `kubeVersion`            | Override Kubernetes version                                                                  | `""`            |
| `nameOverride`           | String to partially override common.names.fullname template (will maintain the release name) | `""`            |
| `fullnameOverride`       | String to fully override common.names.fullname template                                      | `""`            |
| `clusterDomain`          | Kubernetes Cluster Domain                                                                    | `cluster.local` |
| `extraDeploy`            | Array of extra objects to deploy with the release (evaluated as a template)                  | `[]`            |
| `commonLabels`           | Add labels to all the deployed resources                                                     | `{}`            |
| `commonAnnotations`      | Add annotations to all the deployed resources                                                | `{}`            |
| `diagnosticMode.enabled` | Enable diagnostic mode (all probes will be disabled and the command will be overridden)      | `false`         |
| `diagnosticMode.command` | Command to override all containers in the statefulset                                        | `["sleep"]`     |
| `diagnosticMode.args`    | Args to override all containers in the statefulset                                           | `["infinity"]`  |


### PostgreSQL common parameters

| Name                                 | Description                                                                                                          | Value                      |
| ------------------------------------ | -------------------------------------------------------------------------------------------------------------------- | -------------------------- |
| `image.registry`                     | PostgreSQL image registry                                                                                            | `docker.io`                |
| `image.repository`                   | PostgreSQL image repository                                                                                          | `bitnami/postgresql`       |
| `image.tag`                          | PostgreSQL image tag (immutable tags are recommended)                                                                | `14.1.0-debian-10-r80`     |
| `image.pullPolicy`                   | PostgreSQL image pull policy                                                                                         | `IfNotPresent`             |
| `image.pullSecrets`                  | Specify image pull secrets                                                                                           | `[]`                       |
| `image.debug`                        | Specify if debug values should be set                                                                                | `false`                    |
| `auth.enablePostgresUser`            | Assign a password to the "postgres" admin user. Otherwise, remote access will be blocked for this user               | `true`                     |
| `auth.postgresPassword`              | Password for the "postgres" admin user                                                                               | `""`                       |
| `auth.username`                      | Name for a custom user to create                                                                                     | `""`                       |
| `auth.password`                      | Password for the custom user to create                                                                               | `""`                       |
| `auth.database`                      | Name for a custom database to create                                                                                 | `""`                       |
| `auth.replicationUsername`           | Name of the replication user                                                                                         | `repl_user`                |
| `auth.replicationPassword`           | Password for the replication user                                                                                    | `""`                       |
| `auth.existingSecret`                | Name of existing secret to use for PostgreSQL credentials                                                            | `""`                       |
| `auth.usePasswordFiles`              | Mount credentials as a files instead of using an environment variable                                                | `false`                    |
| `architecture`                       | PostgreSQL architecture (`standalone` or `replication`)                                                              | `standalone`               |
| `containerPorts.postgresql`          | PostgreSQL container port                                                                                            | `5432`                     |
| `audit.logHostname`                  | Log client hostnames                                                                                                 | `false`                    |
| `audit.logConnections`               | Add client log-in operations to the log file                                                                         | `false`                    |
| `audit.logDisconnections`            | Add client log-outs operations to the log file                                                                       | `false`                    |
| `audit.pgAuditLog`                   | Add operations to log using the pgAudit extension                                                                    | `""`                       |
| `audit.pgAuditLogCatalog`            | Log catalog using pgAudit                                                                                            | `off`                      |
| `audit.clientMinMessages`            | Message log level to share with the user                                                                             | `error`                    |
| `audit.logLinePrefix`                | Template for log line prefix (default if not set)                                                                    | `""`                       |
| `audit.logTimezone`                  | Timezone for the log timestamps                                                                                      | `""`                       |
| `postgresqlDataDir`                  | PostgreSQL data dir folder                                                                                           | `/bitnami/postgresql/data` |
| `postgresqlSharedPreloadLibraries`   | Shared preload libraries (comma-separated list)                                                                      | `pgaudit`                  |
| `shmVolume.enabled`                  | Enable emptyDir volume for /dev/shm for PostgreSQL pod(s)                                                            | `true`                     |
| `shmVolume.sizeLimit`                | Set this to enable a size limit on the shm tmpfs                                                                     | `""`                       |


### PostgreSQL Primary parameters

| Name                                         | Description                                                                                                              | Value                 |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | --------------------- |
| `primary.configuration`                      | PostgreSQL Primary main configuration to be injected as ConfigMap                                                        | `""`                  |
| `primary.pgHbaConfiguration`                 | PostgreSQL Primary client authentication configuration                                                                   | `""`                  |
| `primary.existingConfigmap`                  | Name of an existing ConfigMap with PostgreSQL Primary configuration                                                      | `""`                  |
| `primary.extendedConfiguration`              | Extended PostgreSQL Primary configuration (appended to main or default configuration)                                    | `""`                  |
| `primary.existingExtendedConfigmap`          | Name of an existing ConfigMap with PostgreSQL Primary extended configuration                                             | `""`                  |
| `primary.initdb.args`                        | PostgreSQL initdb extra arguments                                                                                        | `""`                  |
| `primary.initdb.postgresqlWalDir`            | Specify a custom location for the PostgreSQL transaction log                                                             | `""`                  |
| `primary.initdb.scripts`                     | Dictionary of initdb scripts                                                                                             | `{}`                  |
| `primary.initdb.scriptsConfigMap`            | ConfigMap with scripts to be run at first boot                                                                           | `""`                  |
| `primary.initdb.scriptsSecret`               | Secret with scripts to be run at first boot (in case it contains sensitive information)                                  | `""`                  |
| `primary.initdb.user`                        | Specify the PostgreSQL username to execute the initdb scripts                                                            | `""`                  |
| `primary.initdb.password`                    | Specify the PostgreSQL password to execute the initdb scripts                                                            | `""`                  |
| `primary.standby.enabled`                    | Whether to enable current cluster's primary as standby server of another cluster or not                                  | `false`               |
| `primary.standby.primaryHost`                | The Host of replication primary in the other cluster                                                                     | `""`                  |
| `primary.standby.primaryPort`                | The Port of replication primary in the other cluster                                                                     | `""`                  |
| `primary.extraEnvVars`                       | Array with extra environment variables to add to PostgreSQL Primary nodes                                                | `[]`                  |
| `primary.extraEnvVarsCM`                     | Name of existing ConfigMap containing extra env vars for PostgreSQL Primary nodes                                        | `""`                  |
| `primary.extraEnvVarsSecret`                 | Name of existing Secret containing extra env vars for PostgreSQL Primary nodes                                           | `""`                  |
| `primary.command`                            | Override default container command (useful when using custom images)                                                     | `[]`                  |
| `primary.args`                               | Override default container args (useful when using custom images)                                                        | `[]`                  |
| `primary.livenessProbe.enabled`              | Enable livenessProbe on PostgreSQL Primary containers                                                                    | `true`                |
| `primary.livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe                                                                                  | `30`                  |
| `primary.livenessProbe.periodSeconds`        | Period seconds for livenessProbe                                                                                         | `10`                  |
| `primary.livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe                                                                                        | `5`                   |
| `primary.livenessProbe.failureThreshold`     | Failure threshold for livenessProbe                                                                                      | `6`                   |
| `primary.livenessProbe.successThreshold`     | Success threshold for livenessProbe                                                                                      | `1`                   |
| `primary.readinessProbe.enabled`             | Enable readinessProbe on PostgreSQL Primary containers                                                                   | `true`                |
| `primary.readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe                                                                                 | `5`                   |
| `primary.readinessProbe.periodSeconds`       | Period seconds for readinessProbe                                                                                        | `10`                  |
| `primary.readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe                                                                                       | `5`                   |
| `primary.readinessProbe.failureThreshold`    | Failure threshold for readinessProbe                                                                                     | `6`                   |
| `primary.readinessProbe.successThreshold`    | Success threshold for readinessProbe                                                                                     | `1`                   |
| `primary.startupProbe.enabled`               | Enable startupProbe on PostgreSQL Primary containers                                                                     | `false`               |
| `primary.startupProbe.initialDelaySeconds`   | Initial delay seconds for startupProbe                                                                                   | `30`                  |
| `primary.startupProbe.periodSeconds`         | Period seconds for startupProbe                                                                                          | `10`                  |
| `primary.startupProbe.timeoutSeconds`        | Timeout seconds for startupProbe                                                                                         | `1`                   |
| `primary.startupProbe.failureThreshold`      | Failure threshold for startupProbe                                                                                       | `15`                  |
| `primary.startupProbe.successThreshold`      | Success threshold for startupProbe                                                                                       | `1`                   |
| `primary.customLivenessProbe`                | Custom livenessProbe that overrides the default one                                                                      | `{}`                  |
| `primary.customReadinessProbe`               | Custom readinessProbe that overrides the default one                                                                     | `{}`                  |
| `primary.customStartupProbe`                 | Custom startupProbe that overrides the default one                                                                       | `{}`                  |
| `primary.lifecycleHooks`                     | for the PostgreSQL Primary container to automate configuration before or after startup                                   | `{}`                  |
| `primary.resources.limits`                   | The resources limits for the PostgreSQL Primary containers                                                               | `{}`                  |
| `primary.resources.requests.memory`          | The requested memory for the PostgreSQL Primary containers                                                               | `256Mi`               |
| `primary.resources.requests.cpu`             | The requested cpu for the PostgreSQL Primary containers                                                                  | `250m`                |
| `primary.podSecurityContext.enabled`         | Enable security context                                                                                                  | `true`                |
| `primary.podSecurityContext.fsGroup`         | Group ID for the pod                                                                                                     | `1001`                |
| `primary.containerSecurityContext.enabled`   | Enable container security context                                                                                        | `true`                |
| `primary.containerSecurityContext.runAsUser` | User ID for the container                                                                                                | `1001`                |
| `primary.hostAliases`                        | PostgreSQL primary pods host aliases                                                                                     | `[]`                  |
| `primary.hostNetwork`                        | Specify if host network should be enabled for PostgreSQL pod                                                             | `false`               |
| `primary.hostIPC`                            | Specify if host IPC should be enabled for PostgreSQL pod                                                                 | `false`               |
| `primary.labels`                             | Map of labels to add to the statefulset (postgresql primary)                                                             | `{}`                  |
| `primary.annotations`                        | Annotations for PostgreSQL primary pods                                                                                  | `{}`                  |
| `primary.podLabels`                          | Map of labels to add to the pods (postgresql primary)                                                                    | `{}`                  |
| `primary.podAnnotations`                     | Map of annotations to add to the pods (postgresql primary)                                                               | `{}`                  |
| `primary.podAffinityPreset`                  | PostgreSQL primary pod affinity preset. Ignored if `primary.affinity` is set. Allowed values: `soft` or `hard`           | `""`                  |
| `primary.podAntiAffinityPreset`              | PostgreSQL primary pod anti-affinity preset. Ignored if `primary.affinity` is set. Allowed values: `soft` or `hard`      | `soft`                |
| `primary.nodeAffinityPreset.type`            | PostgreSQL primary node affinity preset type. Ignored if `primary.affinity` is set. Allowed values: `soft` or `hard`     | `""`                  |
| `primary.nodeAffinityPreset.key`             | PostgreSQL primary node label key to match Ignored if `primary.affinity` is set.                                         | `""`                  |
| `primary.nodeAffinityPreset.values`          | PostgreSQL primary node label values to match. Ignored if `primary.affinity` is set.                                     | `[]`                  |
| `primary.affinity`                           | Affinity for PostgreSQL primary pods assignment                                                                          | `{}`                  |
| `primary.nodeSelector`                       | Node labels for PostgreSQL primary pods assignment                                                                       | `{}`                  |
| `primary.tolerations`                        | Tolerations for PostgreSQL primary pods assignment                                                                       | `[]`                  |
| `primary.topologySpreadConstraints`          | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template | `{}`                  |
| `primary.priorityClassName`                  | Priority Class to use for each pod (postgresql primary)                                                                  | `""`                  |
| `primary.schedulerName`                      | Use an alternate scheduler, e.g. "stork".                                                                                | `""`                  |
| `primary.terminationGracePeriodSeconds`      | Seconds PostgreSQL primary pod needs to terminate gracefully                                                             | `""`                  |
| `primary.updateStrategy.type`                | PostgreSQL Primary statefulset strategy type                                                                             | `RollingUpdate`       |
| `primary.updateStrategy.rollingUpdate`       | PostgreSQL Primary statefulset rolling update configuration parameters                                                   | `{}`                  |
| `primary.extraVolumeMounts`                  | Optionally specify extra list of additional volumeMounts for the PostgreSQL Primary container(s)                         | `[]`                  |
| `primary.extraVolumes`                       | Optionally specify extra list of additional volumes for the PostgreSQL Primary pod(s)                                    | `[]`                  |
| `primary.sidecars`                           | Add additional sidecar containers to the PostgreSQL Primary pod(s)                                                       | `[]`                  |
| `primary.initContainers`                     | Add additional init containers to the PostgreSQL Primary pod(s)                                                          | `[]`                  |
| `primary.extraPodSpec`                       | Optionally specify extra PodSpec for the PostgreSQL Primary pod(s)                                                       | `{}`                  |
| `primary.service.type`                       | Kubernetes Service type                                                                                                  | `ClusterIP`           |
| `primary.service.ports.postgresql`           | PostgreSQL service port                                                                                                  | `5432`                |
| `primary.service.nodePorts.postgresql`       | Node port for PostgreSQL                                                                                                 | `""`                  |
| `primary.service.clusterIP`                  | Static clusterIP or None for headless services                                                                           | `""`                  |
| `primary.service.annotations`                | Annotations for PostgreSQL primary service                                                                               | `{}`                  |
| `primary.service.loadBalancerIP`             | Load balancer IP if service type is `LoadBalancer`                                                                       | `""`                  |
| `primary.service.externalTrafficPolicy`      | Enable client source IP preservation                                                                                     | `Cluster`             |
| `primary.service.loadBalancerSourceRanges`   | Addresses that are allowed when service is LoadBalancer                                                                  | `[]`                  |
| `primary.service.extraPorts`                 | Extra ports to expose in the PostgreSQL primary service                                                                  | `[]`                  |
| `primary.persistence.enabled`                | Enable PostgreSQL Primary data persistence using PVC                                                                     | `true`                |
| `primary.persistence.existingClaim`          | Name of an existing PVC to use                                                                                           | `""`                  |
| `primary.persistence.mountPath`              | The path the volume will be mounted at                                                                                   | `/bitnami/postgresql` |
| `primary.persistence.subPath`                | The subdirectory of the volume to mount to                                                                               | `""`                  |
| `primary.persistence.storageClass`           | PVC Storage Class for PostgreSQL Primary data volume                                                                     | `""`                  |
| `primary.persistence.accessModes`            | PVC Access Mode for PostgreSQL volume                                                                                    | `["ReadWriteOnce"]`   |
| `primary.persistence.size`                   | PVC Storage Request for PostgreSQL volume                                                                                | `8Gi`                 |
| `primary.persistence.annotations`            | Annotations for the PVC                                                                                                  | `{}`                  |
| `primary.persistence.selector`               | Selector to match an existing Persistent Volume (this value is evaluated as a template)                                  | `{}`                  |
| `primary.persistence.dataSource`             | Custom PVC data source                                                                                                   | `{}`                  |


### Volume Permissions parameters

| Name                                                   | Description                                                                     | Value                   |
| ------------------------------------------------------ | ------------------------------------------------------------------------------- | ----------------------- |
| `volumePermissions.enabled`                            | Enable init container that changes the owner and group of the persistent volume | `false`                 |
| `volumePermissions.image.registry`                     | Init container volume-permissions image registry                                | `docker.io`             |
| `volumePermissions.image.repository`                   | Init container volume-permissions image repository                              | `bitnami/bitnami-shell` |
| `volumePermissions.image.tag`                          | Init container volume-permissions image tag (immutable tags are recommended)    | `10-debian-10-r327`     |
| `volumePermissions.image.pullPolicy`                   | Init container volume-permissions image pull policy                             | `IfNotPresent`          |
| `volumePermissions.image.pullSecrets`                  | Init container volume-permissions image pull secrets                            | `[]`                    |
| `volumePermissions.resources.limits`                   | Init container volume-permissions resource limits                               | `{}`                    |
| `volumePermissions.resources.requests`                 | Init container volume-permissions resource requests                             | `{}`                    |
| `volumePermissions.containerSecurityContext.runAsUser` | User ID for the init container                                                  | `0`                     |




Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install my-release \
    --set auth.postgresPassword=secretpassword
    postgresql
```

The above command sets the PostgreSQL `postgres` account password to `secretpassword`.

> NOTE: Once this chart is deployed, it is not possible to change the application's access credentials, such as usernames or passwords, using Helm. To change these application credentials after deployment, delete any persistent volumes (PVs) used by the chart and re-deploy it, or use the application's built-in administrative tools if available.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
helm install my-release -f values.yaml postgresql
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Configuration and installation details

### [Rolling VS Immutable tags](https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/)

It is strongly recommended to use immutable tags in a production environment. This ensures your deployment does not change automatically if the same tag is updated with a different image.

Bitnami will release a new chart updating its containers if a new version of the main container, significant changes, or critical vulnerabilities exist.

### Customizing primary and read replica services in a replicated configuration

At the top level, there is a service object which defines the services for both primary and readReplicas. For deeper customization, there are service objects for both the primary and read types individually. This allows you to override the values in the top level service object so that the primary and read can be of different service types and with different clusterIPs / nodePorts. Also in the case you want the primary and read to be of type nodePort, you will need to set the nodePorts to different values to prevent a collision. The values that are deeper in the primary.service or readReplicas.service objects will take precedence over the top level service object.

### Use a different PostgreSQL version

To modify the application version used in this chart, specify a different version of the image using the `image.tag` parameter and/or a different repository using the `image.repository` parameter. Refer to the [chart documentation for more information on these parameters and how to use them with images from a private registry](https://docs.bitnami.com/kubernetes/infrastructure/postgresql/configuration/change-image-version/).

### postgresql.conf / pg_hba.conf files as configMap

This helm chart also supports to customize the PostgreSQL configuration file. You can add additional PostgreSQL configuration parameters using the `primary.extendedConfiguration` parameter as a string. Alternatively, to replace the entire default configuration use `primary.configuration`.

You can also add a custom pg_hba.conf using the `primary.pgHbaConfiguration` parameter.

In addition to these options, you can also set an external ConfigMap with all the configuration files. This is done by setting the `primary.existingConfigmap` parameter. Note that this will override the two previous options.

### Initialize a fresh instance

The [Bitnami PostgreSQL](https://github.com/bitnami/bitnami-docker-postgresql) image allows you to use your custom scripts to initialize a fresh instance. In order to execute the scripts, you can specify custom scripts using the `primary.initdb.scripts` parameter as a string.

In addition, you can also set an external ConfigMap with all the initialization scripts. This is done by setting the `primary.initdb.scriptsConfigMap` parameter. Note that this will override the two previous options. If your initialization scripts contain sensitive information such as credentials or passwords, you can use the `primary.initdb.scriptsSecret` parameter.

The allowed extensions are `.sh`, `.sql` and `.sql.gz`.

### Sidecars

If you need  additional containers to run within the same pod as PostgreSQL (e.g. an additional metrics or logging exporter), you can do so via the `sidecars` config parameter. Simply define your container according to the Kubernetes container spec.

```yaml
# For the PostgreSQL primary
primary:
  sidecars:
  - name: your-image-name
    image: your-image
    imagePullPolicy: Always
    ports:
    - name: portname
     containerPort: 1234
# For the PostgreSQL replicas
readReplicas:
  sidecars:
  - name: your-image-name
    image: your-image
    imagePullPolicy: Always
    ports:
    - name: portname
     containerPort: 1234
```

### Use of global variables

In more complex scenarios, we may have the following tree of dependencies

```
                     +--------------+
                     |              |
        +------------+   Chart 1    +-----------+
        |            |              |           |
        |            --------+------+           |
        |                    |                  |
        |                    |                  |
        |                    |                  |
        |                    |                  |
        v                    v                  v
+-------+------+    +--------+------+  +--------+------+
|              |    |               |  |               |
|  PostgreSQL  |    |  Sub-chart 1  |  |  Sub-chart 2  |
|              |    |               |  |               |
+--------------+    +---------------+  +---------------+
```

The three charts below depend on the parent chart Chart 1. However, subcharts 1 and 2 may need to connect to PostgreSQL as well. In order to do so, subcharts 1 and 2 need to know the PostgreSQL credentials, so one option for deploying could be deploy Chart 1 with the following parameters:

```
postgresql.auth.password=testuser
subchart1.postgresql.auth.username=testuser
subchart2.postgresql.auth.username=testuser
postgresql.auth.password=testpass
subchart1.postgresql.auth.password=testpass
subchart2.postgresql.auth.password=testpass
postgresql.auth.database=testdb
subchart1.postgresql.auth.database=testdb
subchart2.postgresql.auth.database=testdb
```

If the number of dependent sub-charts increases, installing the chart with parameters can become increasingly difficult. An alternative would be to set the credentials using global variables as follows:

```
global.postgresql.auth.username=testuser
global.postgresql.auth.password=testpass
global.postgresql.auth.database=testdb
```

This way, the credentials will be available in all of the subcharts.

## Persistence

The postgres image stores the PostgreSQL data and configurations at the `/postgresql` path of the container.

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, and minikube.
See the [Parameters](#parameters) section to configure the PVC or to disable persistence.

### Setting Pod's affinity

This chart allows you to set your custom affinity using the `XXX.affinity` parameter(s). Find more information about Pod's affinity in the [kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity).

As an alternative, you can use of the preset configurations for pod affinity, pod anti-affinity, and node affinity available at the [helm-common/affinities](https://keshavprasadms.github.io/helm-common/#affinities) chart. To do so, set the `XXX.podAffinityPreset`, `XXX.podAntiAffinityPreset`, or `XXX.nodeAffinityPreset` parameters.

## Troubleshooting

Find more information about how to deal with common errors related to Bitnami's Helm charts in [this troubleshooting guide](https://docs.bitnami.com/general/how-to/troubleshoot-helm-chart-issues).

## Upgrading

Refer to the [chart documentation for more information about how to upgrade from previous releases](https://docs.bitnami.com/kubernetes/infrastructure/postgresql/administration/upgrade/).