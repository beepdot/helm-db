{{/* vim: set filetype=mustache: */}}

{{/*
Create a default fully qualified app name for PostgreSQL Primary objects
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "postgresql.primary.fullname" -}}
{{- if eq .Values.architecture "replication" }}
    {{- printf "%s-primary" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- else -}}
    {{- include "common.names.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name for PostgreSQL read-only replicas objects
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "postgresql.readReplica.fullname" -}}
{{- printf "%s-read" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the default FQDN for PostgreSQL primary headless service
We truncate at 63 chars because of the DNS naming spec.
*/}}
{{- define "postgresql.primary.svc.headless" -}}
{{- printf "%s-hl" (include "postgresql.primary.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Create the default FQDN for PostgreSQL read-only replicas headless service
We truncate at 63 chars because of the DNS naming spec.
*/}}
{{- define "postgresql.readReplica.svc.headless" -}}
{{- printf "%s-hl" (include "postgresql.readReplica.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Return the proper PostgreSQL image name
*/}}
{{- define "postgresql.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper PostgreSQL metrics image name
*/}}
{{- define "postgresql.metrics.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.metrics.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "postgresql.volumePermissions.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.volumePermissions.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "postgresql.imagePullSecrets" -}}
{{ include "common.images.renderPullSecrets" (dict "images" (list .Values.image .Values.volumePermissions.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the name for a custom user to create
*/}}
{{- define "postgresql.username" -}}
{{- if .Values.global.postgresql.auth.username }}
    {{- .Values.global.postgresql.auth.username -}}
{{- else -}}
    {{- .Values.auth.username -}}
{{- end -}}
{{- end -}}

{{/*
Return the name for a custom database to create
*/}}
{{- define "postgresql.database" -}}
{{- if .Values.global.postgresql.auth.database }}
    {{- .Values.global.postgresql.auth.database -}}
{{- else if .Values.auth.database -}}
    {{- .Values.auth.database -}}
{{- end -}}
{{- end -}}

{{/*
Get the password secret.
*/}}
{{- define "postgresql.secretName" -}}
{{- if .Values.global.postgresql.auth.existingSecret }}
    {{- printf "%s" (tpl .Values.global.postgresql.auth.existingSecret $) -}}
{{- else if .Values.auth.existingSecret -}}
    {{- printf "%s" (tpl .Values.auth.existingSecret $) -}}
{{- else -}}
    {{- printf "%s" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a secret object should be created
*/}}
{{- define "postgresql.createSecret" -}}
{{- if not (or .Values.global.postgresql.auth.existingSecret .Values.auth.existingSecret) -}}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return PostgreSQL service port
*/}}
{{- define "postgresql.service.port" -}}
{{- if .Values.global.postgresql.service.ports.postgresql }}
    {{- .Values.global.postgresql.service.ports.postgresql -}}
{{- else -}}
    {{- .Values.primary.service.ports.postgresql -}}
{{- end -}}
{{- end -}}

{{/*
Return PostgreSQL service port
*/}}
{{- define "postgresql.readReplica.service.port" -}}
{{- if .Values.global.postgresql.service.ports.postgresql }}
    {{- .Values.global.postgresql.service.ports.postgresql -}}
{{- else -}}
    {{- .Values.readReplicas.service.ports.postgresql -}}
{{- end -}}
{{- end -}}

{{/*
Get the PostgreSQL primary configuration ConfigMap name.
*/}}
{{- define "postgresql.primary.configmapName" -}}
{{- if .Values.primary.existingConfigmap -}}
    {{- printf "%s" (tpl .Values.primary.existingConfigmap $) -}}
{{- else -}}
    {{- printf "%s-configuration" (include "postgresql.primary.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a configmap object should be created for PostgreSQL primary with the configuration
*/}}
{{- define "postgresql.primary.createConfigmap" -}}
{{- if and (or .Values.primary.configuration .Values.primary.pgHbaConfiguration) (not .Values.primary.existingConfigmap) }}
    {{- true -}}
{{- else -}}
{{- end -}}
{{- end -}}

{{/*
Get the PostgreSQL primary extended configuration ConfigMap name.
*/}}
{{- define "postgresql.primary.extendedConfigmapName" -}}
{{- if .Values.primary.existingExtendedConfigmap -}}
    {{- printf "%s" (tpl .Values.primary.existingExtendedConfigmap $) -}}
{{- else -}}
    {{- printf "%s-extended-configuration" (include "postgresql.primary.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a configmap object should be created for PostgreSQL primary with the extended configuration
*/}}
{{- define "postgresql.primary.createExtendedConfigmap" -}}
{{- if and .Values.primary.extendedConfiguration (not .Values.primary.existingExtendedConfigmap) }}
    {{- true -}}
{{- else -}}
{{- end -}}
{{- end -}}

{{/*
 Create the name of the service account to use
 */}}
{{- define "postgresql.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return true if a configmap should be mounted with PostgreSQL configuration
*/}}
{{- define "postgresql.mountConfigurationCM" -}}
{{- if or .Values.primary.configuration .Values.primary.pgHbaConfiguration .Values.primary.existingConfigmap }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Get the initialization scripts ConfigMap name.
*/}}
{{- define "postgresql.initdb.scriptsCM" -}}
{{- if .Values.primary.initdb.scriptsConfigMap -}}
    {{- printf "%s" (tpl .Values.primary.initdb.scriptsConfigMap $) -}}
{{- else -}}
    {{- printf "%s-init-scripts" (include "postgresql.primary.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Get the readiness probe command
*/}}
{{- define "postgresql.readinessProbeCommand" -}}
{{- $customUser := include "postgresql.username" . }}
- |
{{- if (include "postgresql.database" .) }}
  exec pg_isready -U {{ default "postgres" $customUser | quote }} -d "dbname={{ include "postgresql.database" . }}" -h 127.0.0.1 -p {{ .Values.containerPorts.postgresql }}
{{- end }}
{{- if contains "bitnami/" .Values.image.repository }}
  [ -f /opt/bitnami/postgresql/tmp/.initialized ] || [ -f /bitnami/postgresql/.initialized ]
{{- end -}}
{{- end -}}

{{/*
Compile all warnings into a single message, and call fail.
*/}}
{{- define "postgresql.validateValues" -}}
{{- $messages := list -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{- printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}