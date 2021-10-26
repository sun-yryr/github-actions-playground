# Security Report - {{ escapeXML ( index . 0 ).Target }}

## timestamp

{{ getCurrentTime }}

{{- range . }}

## {{ escapeXML .Type }}

{{- if (eq (len .Vulnerabilities) 0) }}
No Vulnerabilities found
{{- else }}
| LIBRARY | VULNERABILITY ID | SEVERITY | INSTALLED VERSION | FIXED VERSION | TITLE |
|---|---|---|---|---|---| 
{{- range .Vulnerabilities }}
| {{ escapeXML .PkgName }} | {{ escapeXML .VulnerabilityID }} | {{ escapeXML .Vulnerability.Severity }} | {{ escapeXML .InstalledVersion }} | {{ escapeXML .FixedVersion }} | {{ escapeXML .Description }} |
{{- end }}
{{- end }}
{{- end }}
