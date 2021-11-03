{{/* vim: set filetype=mustache: */}}

{{- define "iredmail.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}

{{/*
Return the proper iRedMail image name
*/}}
{{- define "iredmail.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "iredmail.volumePermissions.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.volumePermissions.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "iredmail.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.image .Values.metrics.image .Values.volumePermissions.image) "global" .Values.global) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "iredmail.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the configmap with the iRedMail configuration
*/}}
{{- define "iredmail.configmapName" -}}
{{- if .Values.existingConfigmap -}}
    {{- printf "%s" (tpl .Values.existingConfigmap $) -}}
{{- else -}}
    {{- printf "%s" (include "iredmail.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a configmap object should be created for iRedMail Primary
*/}}
{{- define "iredmail.createConfigmap" -}}
{{- if and .Values.configuration (not .Values.existingConfigmap) }}
    {{- true -}}
{{- else -}}
{{- end -}}
{{- end -}}

{{/*
Return the secret with iRedMail credentials
*/}}
{{- define "iredmail.secretName" -}}
    {{- if .Values.auth.existingSecret -}}
        {{- printf "%s" .Values.auth.existingSecret -}}
    {{- else -}}
        {{- printf "%s" (include "common.names.fullname" .) -}}
    {{- end -}}
{{- end -}}

{{/*
Return true if a secret object should be created for iRedMail
*/}}
{{- define "iredmail.createSecret" -}}
{{- if and (not .Values.auth.existingSecret) (not .Values.auth.customPasswordFiles) }}
    {{- true -}}
{{- else -}}
{{- end -}}
{{- end -}}

{{/*
Compile all warnings into a single message, and call fail.
*/}}
{{- define "iredmail.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "iredmail.validateValues.architecture" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}