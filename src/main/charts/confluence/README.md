# confluence

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 7.9.0-beta1-jdk11](https://img.shields.io/badge/AppVersion-7.9.0--beta1--jdk11-informational?style=flat-square)

A chart for installing Confluence DC on Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainers | list | `[]` | Additional container definitions that will be added to all Confluence pods |
| additionalInitContainers | list | `[]` | Additional initContainer definitions that will be added to all Confluence pods |
| affinity | object | `{}` | Standard Kubernetes affinities that will be applied to all Confluence and Synchrony pods |
| confluence.additionalBundledPlugins | list | `[]` | Specifies a list of additional Confluence plugins that should be added to the Confluence container. These are specified in the same manner as the additionalLibraries field, but the files will be loaded as bundled plugins rather than as libraries. |
| confluence.additionalEnvironmentVariables | list | `[]` | Defines any additional environment variables to be passed to the Confluence container. See https://hub.docker.com/r/atlassian/confluence-server for supported variables. |
| confluence.additionalJvmArgs | list | `[]` | Specifies a list of additional arguments that can be passed to the Confluence JVM, e.g. system properties |
| confluence.additionalLibraries | list | `[]` | Specifies a list of additional Java libraries that should be added to the Confluence container. Each item in the list should specify the name of the volume which contain the library, as well as the name of the library file within that volume's root directory. Optionally, a subDirectory field can be included to specify which directory in the volume contains the library file. |
| confluence.additionalVolumeMounts | list | `[]` | Defines any additional volumes mounts for the Confluence container. These can refer to existing volumes, or new volumes can be defined in volumes.additional. |
| confluence.gid | string | `"2002"` | The GID used by the Confluence docker image |
| confluence.license.secretKey | string | `"license-key"` | The key in the Kubernetes Secret which contains the Confluence license key |
| confluence.license.secretName | string | `"confluence-license"` | The name of the Kubernetes Secret which contains the Confluence license key |
| confluence.ports.hazelcast | int | `5701` | The port on which the Confluence container listens for Hazelcast traffic |
| confluence.ports.http | int | `8090` | The port on which the Confluence container listens for HTTP traffic |
| confluence.readinessProbe.failureThreshold | int | `30` | The number of consecutive failures of the Confluence container readiness probe before the pod fails readiness checks |
| confluence.readinessProbe.initialDelaySeconds | int | `10` | The initial delay (in seconds) for the Confluence container readiness probe, after which the probe will start running |
| confluence.readinessProbe.periodSeconds | int | `5` | How often (in seconds) the Confluence container readiness robe will run |
| confluence.resources.container | object | `{}` | Specifies the standard Kubernetes resource requests and/or limits for the Confluence container. It is important that if the memory resources are specified here, they must allow for the size of the Confluence JVM. That means the maximum heap size, the reserved code cache size, plus other JVM overheads, must be accommodated. Allowing for (maxHeap+codeCache)*1.5 would be an example. |
| confluence.resources.jvm.maxHeap | string | `"1g"` | The maximum amount of heap memory that will be used by the Confluence JVM |
| confluence.resources.jvm.minHeap | string | `"1g"` | The minimum amount of heap memory that will be used by the Confluence JVM |
| confluence.resources.jvm.reservedCodeCache | string | `"512m"` | The memory reserved for the Confluence JVM code cache |
| confluence.service.port | int | `80` | The port on which the Confluence Kubernetes service will listen |
| confluence.service.type | string | `"ClusterIP"` | The type of Kubernetes service to use for Confluence |
| database.credentials.passwordSecretKey | string | `"password"` | The key in the Secret used to store the database login password |
| database.credentials.secretName | string | `"confluence-database-credentials"` | The name of the Kubernetes Secret that contains the database login credentials. |
| database.credentials.usernameSecretKey | string | `"username"` | The key in the Secret used to store the database login username |
| database.type | string | `nil` | The type of database being used. Valid values include 'postgresql', 'mysql', 'oracle', 'mssql'. |
| database.url | string | `nil` | The JDBC URL of the database to be used by Confluence and Synchrony, e.g. jdbc:postgresql://host:port/database |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"atlassian/confluence-server"` |  |
| image.tag | string | `nil` | The docker image tag to be used. Defaults to the Chart appVersion. |
| nodeSelector | object | `{}` | Standard Kubernetes node-selectors that will be applied to all Confluence and Synchrony pods |
| podAnnotations | object | `{}` | Specify additional annotations to be added to all Confluence and Synchrony pods |
| replicaCount | int | `1` | The initial number of pods that should be started at deployment of each of Confluence and Synchrony. Note that because Confluence requires initial manual configuration after the first pod is deployed, and before scaling up to additional pods, this should always be kept as 1. |
| serviceAccountName | string | `nil` | Specifies which serviceAccount to use for the pods. If not specified, the kubernetes default will be used. |
| synchrony.ingressUrl | string | `nil` | The base URL of the Synchrony service. This will be the URL that users' browsers will be given to communicate with Synchrony, as well as the URL that the Confluence service will use to communicate directly with Synchrony, so the URL must be resovable both from inside and outside the Kubernetes cluster. |
| synchrony.ports.hazelcast | int | `5701` | The port on which the Synchrony container listens for Hazelcast traffic |
| synchrony.ports.http | int | `8091` | The port on which the Synchrony container listens for HTTP traffic |
| synchrony.readinessProbe.failureThreshold | int | `30` | The number of consecutive failures of the Synchrony container readiness probe before the pod fails readiness checks |
| synchrony.readinessProbe.initialDelaySeconds | int | `5` | The initial delay (in seconds) for the Synchrony container readiness probe, after which the probe will start running |
| synchrony.readinessProbe.periodSeconds | int | `1` | How often (in seconds) the Synchrony container readiness robe will run |
| synchrony.service.port | int | `80` | The port on which the Synchrony Kubernetes service will listen |
| synchrony.service.type | string | `"ClusterIP"` | The type of Kubernetes service to use for Synchrony |
| tolerations | list | `[]` | Standard Kubernetes tolerations that will be applied to all Confluence and Synchrony pods |
| volumes.additional | list | `[]` | Defines additional volumes that should be applied to all Confluence pods. Note that this will not create any corresponding volume mounts; those needs to be defined in confluence.additionalVolumeMounts |
| volumes.localHome.mountPath | string | `"/var/atlassian/application-data/confluence"` | Specifies the path in the Confluence container to which the local-home volume will be mounted. |
| volumes.localHome.resources | object | `{"requests":{"storage":"1Gi"}}` | Specifies the standard Kubernetes resource requests and/or limits for the Confluence local-home volume. |
| volumes.localHome.storageClassName | string | `nil` | Specifies the name of the storage class that should be used for the Confluence local-home volume |
| volumes.sharedHome.mountPath | string | `"/var/atlassian/application-data/shared-home"` | Specifies the path in the Confluence container to which the shared-home volume will be mounted. |
| volumes.sharedHome.nfsPermissionFixer.command | string | `nil` | By default, the fixer will change the group ownership of the volume's root directory to match the Confluence container's GID (2002), and then ensures the directory is group-writeable. If this is not the desired behaviour, command used can be specified here. |
| volumes.sharedHome.nfsPermissionFixer.enabled | bool | `true` | If enabled, this will alter the shared-home volume's root directory so that Confluence can write to it. This is a workaround for a Kubernetes bug affecting NFS volumes: https://github.com/kubernetes/examples/issues/260 |
| volumes.sharedHome.nfsPermissionFixer.mountPath | string | `"/shared-home"` | The path in the initContainer where the shared-home volume will be mounted |
| volumes.sharedHome.subPath | string | `nil` | Specifies the sub-directory of the shared-home volume which will be mounted in to the Confluence container. |
| volumes.sharedHome.volumeClaimName | string | `"confluence-shared-home"` | The name of the PersistentVolumeClaim which will be used for the shared-home volume |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.4.0](https://github.com/norwoodj/helm-docs/releases/v1.4.0)
