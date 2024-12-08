---
title: "Impure Estimates"
summary: "Figuring out trade-offs are difficult. Don't make them unfair too."
date: "2024-11-26"
tags: [ "processes", "2024"]
categories: [ "ruminations" ]

toc: true
readTime: true
math: true
showTags: true
autonumber: false
hideBackToTop: false
---

## The Question

I've been thinking about estimates recently – not the 'how' part of it in the sense of "how do you make good software
estimates" but a different 'how'. The question of "how do you negotiate software estimates with stakeholders".

Note, for the rest of this post assume that the 'stakeholders' are non-technical / management / business folk - however
you'd like to categorize them. Typically, we call 'em 'Business'.

My gut reaction to this rabbit-hole was that – if you worked at a company where software was the product, and
consequently software engineers were 'first-class' citizens, then this wouldn't be much of a problem. After all, it
would be a given that an estimate would be respected (yet subject to some negotiation)  and if you wanted it done '
right', you would give your engineers the time to build it 'right' (and then some).

In the ideal scenario this negotiation would take place *after* some estimate has already been made for a core set of
requirements. At which point the conversation becomes one of trade-offs given some constraints. This could be on a
number of dimensions but my mental model has these classified as: `Completeness`, `Quality`, `Capacity`,
`Time`, and`Sanity`. At this point, stakeholders would have been made aware of the *consequences* of their choices,
since it's ultimately their decision. The engineers on the other hand would be able to work on the project having buy-in
from business lest things go south.

Maybe I'm being delusional and this literally *isn't* how any tech company operates. But okay. Let's consider this a '
good' approach to the software estimation. Good in terms of:

1. Everyone being on the same page
2. Engineers being empowered to make decisions given transparent requirements

## The Reality of Things Isn't Too Straightforward

My experience with software estimates has been pretty much the opposite of what I've described above. I'll chalk that
up to working on experimental products (in a B2B environment) where we're still trying to find our product-market fit.
Where we build for our users, and a lot of our timelines are based on what these users (often-times enterprise grade)
want. It makes perfect sense then *why* timelines are often negotiated independent of engineering input.
Because the dynamic would be between `Customer`s and the `Business`, because that's what makes us money, and it's
difficult to justify the value of software that has no users. At this stage, there's already a ceiling imposed on the
estimate (i.e. a deadline), and it's up to the engineers to deliver those promised features within the timeline.

The problem in the "these aren't estimated but rather deadlines" scenario is that constraints are presupposed on the
project before engineering have had a chance to give their input. Generally speaking, amongst the five axes listed
above, three of them are would have been fixed for you. Namely, `Completeness`, `Time`, and `Quality`. If you've
promised feature X to be delivered by Y and working under some performance or reliability constraints Z. Well - that
doesn't sound fun for anyone.

With only the `Capacity`, `Sanity` axes left, there's no good option here. Either allocate more engineering
resources to the project, which is easy to mismanage giving you diminishing returns for the project. Or, ask what
engineers you do have to trade their sanity in order to grind out the project.

Alright, I'm aware that this is a bit of an extreme view of things. Rarely do we get to work in a way where *most* if
not *all* the constraints are up for negotiation. The point is, the *more* of those constraints you have open for
negotiation at the time of bringing your engineers into the fray - the better your odds are of getting the project done
while keeping everyone involved happy (or at least satisfied).

## So What's The Answer?

Show them this post ha.

But seriously, sometimes the cards are stacked against you. It's ultimately up to the organization to empower its
engineers in such a way that they have agency over the constraints of the project.

If you *don't* feel that that's the case. It's unlikely that culture with respects to this will change, so *perhaps*
it's time to move on.
