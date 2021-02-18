# (Not Quite) Enterprise Scale Landing Zones
Use Enterprise Scale Landing Zone principles but on a smaller, cheaper scale. I won't be deploying resources like Virtual WAN and Azure Firewall as they don't scale down to my small dev/test needs. The preference is to use consumption/serverless type resources (where appropriate).

Why?

I don't think that deploy-if-not-exists policies are quite ready for Prime-Time. They are difficult to author, test, debug and maintain. Maybe one day I will use them but I will instead use the right tool for the job.

Azure Policy (Deny, Append, Audit) - Put Guardrails in the right places
Terraform - Infrastructure Deployment
Azure Automation - Updates, Inventory and Desired State Configuration
Log Analytics/Azure Monitor - Logging/Platform Monitoring
Application Insights - Application Performance Monitoring
Azure DevOps - Work Tracking, CI/CD
Github - Source Control


TODO

Subscription Activity Logs to Log Analytics
Azure Sentinel Workspace
