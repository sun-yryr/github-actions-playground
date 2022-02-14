# Security Report - {{ escapeXML ( index . 0 ).Target }}

## timestamp

{{ now | date "2006-01-02 15:04:05 (MST)" }}

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
