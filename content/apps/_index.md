---
title: "Apps"

# Pages for my apps (privacy policies etc.) - reachable by URL only, never listed or indexed
build:
  render: never
  list: never
cascade:
  - target:
      kind: page
    build:
      list: never
      render: always
    sitemap:
      disable: true
    robots: "noindex, nofollow"
    hideBreadcrumbs: true
    readTime: false
  - target:
      kind: section
    build:
      list: never
      render: never
---
