{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "confluence.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
The name the synchrony app within the chart.
TODO: This will break if the confluence.name exceeds 63 characters, need to find a more rebust way to do this
*/}}
{{- define "synchrony.name" -}}
{{ include "confluence.name" . }}-synchrony
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "confluence.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
The full-qualfied name of the synchrony app within the chart.
TODO: This will break if the confluence.fullname exceeds 63 characters, need to find a more rebust way to do this
*/}}
{{- define "synchrony.fullname" -}}
{{ include "confluence.fullname" . }}-synchrony
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "confluence.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
These labels will be applied to all Confluence (non-Synchrony) resources in the chart
*/}}
{{- define "confluence.labels" -}}
helm.sh/chart: {{ include "confluence.chart" . }}
{{ include "confluence.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ with .Values.additionalLabels }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{/*
These labels will be applied to all Synchrony resources in the chart
*/}}
{{- define "synchrony.labels" -}}
helm.sh/chart: {{ include "confluence.chart" . }}
{{ include "synchrony.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ with .Values.additionalLabels }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels for finding Confluence (non-Synchrony) resources
*/}}
{{- define "confluence.selectorLabels" -}}
app.kubernetes.io/name: {{ include "confluence.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels for finding Synchrony resources
*/}}
{{- define "synchrony.selectorLabels" -}}
app.kubernetes.io/name: {{ include "synchrony.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "confluence.sysprop.hazelcastListenPort" -}}
-Dconfluence.cluster.hazelcast.listenPort={{ .Values.confluence.ports.hazelcast }}
{{- end }}

{{- define "confluence.sysprop.synchronyServiceUrl" -}}
-Dsynchrony.service.url={{ .Values.synchrony.ingressUrl }}/v1
{{- end }}

{{- define "confluence.sysprop.disableHomeLogAppender" -}}
-DConfluenceHomeLogAppender.disabled=true
{{- end }}

{{/*
The command that should be run by the nfs-fixer init container to correct the permissions of the shared-home root directory.
*/}}
{{- define "sharedHome.permissionFix.command" -}}
{{- if .Values.volumes.sharedHome.nfsPermissionFixer.command }}
{{ .Values.volumes.sharedHome.nfsPermissionFixer.command }}
{{- else }}
{{- printf "(chgrp %s %s; chmod g+w %s)" .Values.confluence.gid .Values.volumes.sharedHome.nfsPermissionFixer.mountPath .Values.volumes.sharedHome.nfsPermissionFixer.mountPath }}
{{- end }}
{{- end }}

{{- define "confluence.image" -}}
{{- if .Values.image.registry -}}
{{ .Values.image.registry}}/{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}
{{- else -}}
{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end }}
{{- end }}

{{/*
For each additional library declared, generate a volume mount that injects that library into the Confluence lib directory
*/}}
{{- define "confluence.additionalLibraries" -}}
{{- range .Values.confluence.additionalLibraries -}}
- name: {{ .volumeName }}
  mountPath: "/opt/atlassian/confluence/confluence/WEB-INF/lib/{{ .fileName }}"
  {{- if .subDirectory }}
  subPath: {{ printf "%s/%s" .subDirectory .fileName | quote }}
  {{- else }}
  subPath: {{ .fileName | quote }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
For each additional plugin declared, generate a volume mount that injects that library into the Confluence plugins directory
*/}}
{{- define "confluence.additionalBundledPlugins" -}}
{{- range .Values.confluence.additionalBundledPlugins -}}
- name: {{ .volumeName }}
  mountPath: "/opt/atlassian/confluence/confluence/WEB-INF/atlassian-bundled-plugins/{{ .fileName }}"
  {{- if .subDirectory }}
  subPath: {{ printf "%s/%s" .subDirectory .fileName | quote }}
  {{- else }}
  subPath: {{ .fileName | quote }}
  {{- end }}
{{- end }}
{{- end }}
