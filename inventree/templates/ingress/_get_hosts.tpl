{{/* Return list of hosts defined in ingresses */}}
{{- define "ingress.listHosts" -}}
  {{- $rootContext := .data -}}
  {{- $data := list -}}

  {{- $enabledIngresses := (include "ingress.getEnabled" (dict "rootContext" $rootContext ) | fromYaml ) -}}

  {{- range $id := keys $enabledIngresses -}}
    {{- $ingressObject := (include "ingress.getById" (dict "rootContext" $rootContext "id" $id) | fromYaml) -}}
    {{- range $ingressObject.hosts -}}
      {{- if $ingressObject.tls -}}
         {{- $data = (append $data (print "https://" .host)) -}}
      {{- else -}}
         {{- $data = (append $data (print "http://" .host)) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- join "," ($data |uniq) | quote -}}
{{- end -}}

{{/* Return list of hosts defined in ingresses for server_name */}}
{{- define "ingress.listServers" -}}
  {{- $rootContext := .data -}}
  {{- $data := list -}}

  {{- $enabledIngresses := (include "ingress.getEnabled" (dict "rootContext" $rootContext ) | fromYaml ) -}}

  {{- range $id := keys $enabledIngresses -}}
    {{- $ingressObject := (include "ingress.getById" (dict "rootContext" $rootContext "id" $id) | fromYaml) -}}
    {{- range $ingressObject.hosts -}}
      {{- $data = append $data .host -}}
    {{- end -}}
  {{- end -}}
  {{- join " " ($data |uniq) -}}
{{- end -}}
