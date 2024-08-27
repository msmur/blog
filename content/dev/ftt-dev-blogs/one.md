---
title: "Fixed Term Track | Dev Blog #1"
summary: "(Possibly) An introduction to the project and my philosophy on these programming side-quests!"
date: "2024-08-19"
tags: [ "web server", "golang" ]
projects: "fixed-term-track"
categories: [ "dev-blogs" ]

toc: true
readTime: true
math: true
showTags: true
autonumber: false
hideBackToTop: false
---

## Disclaimer

This first developer blog entry[^1] is a bit similar to infamous cooking recipe websites where _what you're looking
for_ is buried under 10 react components, 8 images of food that aren't actually the food you were looking for, and a
backstory you didn't care to learn about that day.

Well – if I haven't lost you already. A major part of this entry is discussing what I consider a 'project' and how I
think about it. It's a bit of a reflective piece, and I'll be honest **I** am the target audience. Well, me and others
who're interested in getting started with something similar!

If you're interested in the actual nitty-gritty details, go to the next entry!

## Context

This project really came into existence when I realized I was mostly a typescript one-trick and I needed to learn
golang.

Yes, _need_, and yes, _golang_ not some other language.

The engineering org at my company utilizes both TS and Go, and it would look pretty bad on me if I wasn't able to use
both (at least look good enough to not draw undue attention to myself ha)

In the past I've had trouble working on side projects like this one. Ultimately, they are meant to be learning
experiences, but it's pretty difficult to keep up the habit of working on such projects.

Especially after the initial dopamine hit of 'start something new' and 'get something running'.

I've tried to change my mental model on what this kind of project is meant to be (and accomplish).[^2] Personally, I set
two requirements that I had to meet before I could consider starting a project.

1. What do I want to play around with? In terms of the languages/frameworks/tools/technologies I want to learn.
2. What does the end look like? In terms of core functionality that the project will aim to provide.

The order _sort of_ matters. In the sense that learning is the primary objective and picking a project that helps you
utilize those things you want to learn would be ideal.

Now that I wrote that down... is it a bit of a contradiction? After all, how would you know what projects would be ideal
for the stack you want to learn if you don't even know that stack? The way I see it you're not going in completely
blind. You're not trying to optimize for the perfect project either ( that seems too artificially constructed to be
useful to you). Instead, you have some broad ideas of what these

A stupid simple example would be that Go is pretty versatile for backend development, and it's a no-brainer for me to
consider writing a REST API in Go with a PostgreSQL database since I'm modelling relational data.[^3]

The project **absolutely** needs to have a concrete end goal. This is to ensure that you're always working towards
something, even if that might be a long time coming.

I'm sure this opinion will garner disagreement. Perhaps along the lines of, "_But Maahir_, as a developer you should
feel comfortable throwing all your code away and not feel pressured into continuing work you don't want to do,
especially since this is done in your free time!"

I agree. That _should_ be the case if you're experimenting. _But_, if you're going to call it a 'project', have it be
publicly accessible, _and_ actively talk about it. Well, I'd hold those works to a higher standard.

Not in forcing yourself to persevere when you aren't enjoying the journey, but at least in having an end-goal to see the
project through to completion.

It doesn't have to be a lofty goal either. The goalpost only exists to tell you when you're done. It allows you to
breathe a sigh of relief and tell yourself that you've accomplished something and can now move on to the next thing
without wasting any mental energy on thinking `What If?'. It forces you to be honest about what's necessary to get
things done, instead of mindlessly optimizing for the 'perfect' project.

Get those core features done. Shoot past that end goal. _Then_ consider all the other stuff.

## My Goals

Learning wot?

A couple of things:

1. Golang and its ecosystem of libraries for backend development
2. Develop an end-to-end microservice of sorts with logging, tracing, tests, openapi specs and the whole shebang

Building wot?

A REST API that provides a simple interface for tracking and managing fixed term investments.[^4]

## My Requirements

An excerpt from my 'quick and dirty' requirement spec:

I would like to be able to:

1. Create a record of my fixed term investments
2. Track the returns on these investments
3. Get notifications about upcoming payouts
4. Calculate metrics on investments/returns aggregated by time/currency

Those were my core functionalities, getting them done was my 'end goal'.

## The State of the Project

The [Web Server Repository](https://github.com/mesmur/fixed-term-track-web-server)

I've had a good bit of fun with the project so far. Getting help from Copilot Chat has made it really easy to scaffold
in a lot of the boilerplate necessary to set up a REST API as well as initializing the libraries.

In terms of core functionality this project is already 'complete'. I am having second thoughts on how I designed
things – but more on that in a future entry. One of the things I want to 'polish' up is writing more idiomatic Go code.
In my opinion everything I've written up is 'too simple'[^5] and there's little in the way of the Domain Driven Design (
DDD) that I love preaching.

I am more than a little lost on _how_ to do that though. Now that I've actually written something and have pulled myself
out of tutorial hell, it would be a good time to look at other projects and see what I can do to incrementally improve
this project.

In terms of what's left: I haven't met my 'learning' goals, nor have I figured out how I want to consume the API, or
more pertinently even deploy it. I don't want to maintain another website and learning some mobile dev sounds like the
way.

[^1]: Hopefully there will be many more such first entries for future projects
[^2]: This is something worth exploring further. I'll likely write about it in a future post
[^3]: Unless you're learning Rust. Rust devs will reassure you that your choice of project doesn't matter since Rust can
do it all
[^4]: Before you ask me why the financial institution that holds these investments don't offer such a service. Well –
they don't
[^5]: _Not a bad thing_ but part of getting good enough at some tech stack is to be able to write and think about it at
a level well enough to be considered a 'professional' which, at this point in my career is a high priority of mine
