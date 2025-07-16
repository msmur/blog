---
title: "Thinking in Models - Our Layers"
summary: "Here, there, and everywhere: settling on our layers of abstraction"
date: "2025-07-16"
tags: [ "2025", "backend", "abstraction", "DDD" ]
series: "thinking-in-models"
categories: [ "devlogs" ]

toc: true
readTime: true
math: true
showTags: true
autonumber: false
hideBackToTop: false
---

## Prelude

The goal of this piece is to convince myself that the same `resource` (or `concept`) at various layers of abstraction
*may* deserve their own model in code. Using standard OOP design philosophy that translates to having a separate
`Class`, or something simpler like a dictionary.

There is one thing to be accomplished before I can do that though, namely figuring out what those various layers of
abstraction are. That's been the most difficult part - figuring out clear distinctions in my mental model that
draw boundaries, not muddle them.

This piece is largely inspired by my TL, who, when I was a junior, taught me there was more to modelling than simply
using the same ORM entity from Database to JSON response. Also inspired by various discussions
on [HackerNews](https://news.ycombinator.com/) that I've lurked on over the years,
and [Amundsen's Maxim](https://www.amundsens-maxim.com/) which I discovered quite recently which was *almost* what I
wanted to see.

## The Five

I consider the following layers when designing an implementation for some `resource`.

1. **The Database Layer** - the data model
2. **The Domain Layer** - the domain model
3. **The Synchronous Communication Layer** - the sync DTO model(s) (Responses and Webhooks)
4. **The Asynchronous Communication Layer** - the async DTO model
5. **The Presentation Layer** - the view model

I don't necessarily go in expecting to set up a different model at every layer, but it helps immensely to have this
mental model I can refer to when complexity starts to mount and your system is anything more than just a CRUD layer.

This series will follow be structured to have each layer discussed in its own piece, mostly to help me write
consistently instead of sitting on a really large essay forever.