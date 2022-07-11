---
to: "<%= ci.includes('Dependabot') ? `${project}/.github/dependabot.yml` : null %>"
---
updates:
- package-ecosystem: nuget
  directory: "/"
  schedule:
    interval: daily
  open-pull-requests-limit: 10
#  reviewers:
#  - "<%= author %>"
