{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "$ServiceName.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "$ServiceName.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | lower |  trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | lower |  trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | lower | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "$ServiceName.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "$ServiceName.labels" -}}
helm.sh/chart: {{ include "$ServiceName.chart" . }}
{{ include "$ServiceName.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "$ServiceName.selectorLabels" -}}
app.kubernetes.io/name: {{ include "$ServiceName.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
aadpodidbinding label
*/}}
{{- define "$ServiceName.aadpodidbindingLabel" -}}
aadpodidbinding: {{ .Values.aadpodidentity.aadpodidbinding }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "$ServiceName.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "$ServiceName.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
servicelabel label
*/}}
{{- define "$ServiceName.servicelabelLabel" -}}
ComponentId: {{ .Values.servicelabel.ComponentId }}
ComponentName: {{ .Values.servicelabel.ComponentName }}
Service: {{ .Values.servicelabel.Service }}
ServiceLine: {{ .Values.servicelabel.ServiceLine }}
ServiceOffering: {{ .Values.servicelabel.ServiceOffering }}
app: {{ .Values.servicelabel.app }}
{{- end -}}
