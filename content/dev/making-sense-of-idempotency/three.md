---
title: "Persistence Causes Persistent Issues"
summary: "Databases help you achieve idempotency, but it's just so easy to get it wrong"
date: "2024-11-24"
tags: [ "idempotency", "backend", "database" ]
series: "making-sense-of-idempotency"
categories: [ "learnings" ]

toc: true
readTime: true
math: true
showTags: true
autonumber: false
hideBackToTop: false
---

## Setting the Stage

The previous essay had us run through the definition of idempotency as well as understand why its implementation is
non-trivial and dependent on what our code is meant to do.

In this essay we'll explore how persistence is a pre-requisite in making our operations idempotent. We'll
look at how common patterns in utilizing databases can be problematic, and then we'll incrementally move
ourselves towards guiding principles 'that work'.

If your system doesn't use a database, well, that's likely a sign that idempotency might not be relevant to you. _It
does not_ mean that you are idempotent by default. If

---

1. The importance of persistent storage
2. What a linear sequence of operations looks like, and why that's problematic (same example as last time)
3. What needs to be done to change things (move things forward, introduce an idempotency identifier)
4. Handling race conditions with multiple clients
5. A note on maintaining alignment between your data and domain model
6. 
