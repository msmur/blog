---
title: "BookLens | Devlog #1"
summary: "Towards a prettier Goodreads. Picking tools, building backends, and giving up on sending E-mails because I ain't got it in me."
date: "2024-10-06"
tags: [ "frontend", "serverless", "sveltekit", "aws lambda", "2024" ]
categories: [ "devlogs" ]

toc: true
readTime: true
math: true
showTags: true
autonumber: false
hideBackToTop: false
---

## The Inspiration

I've been a [Goodreads](https://www.goodreads.com/) user for many years, and while I've tried alternatives like
[StoryGraph](https://www.thestorygraph.com/), I've found myself coming back to Goodreads because it does make it
easy to track books.

On topic, really, there's just one thing I've wanted from Goodreads and that's an easier way to showcase the books I've
read. Seeing what a person is reading is such a great way to get know them. It's really a kind of lens into their
lives.

## Getting Started

I decided to jump right in and start building the frontend. After all, I had access to my own Goodreads export. It would
be a solid start to figure out how to parse and display that one CSV instead of thinking about file uploads, storage,
and other shenanigans.

Since typescript was what I am most familiar with, I decided to go with Svelte as my framework of choice for the
frontend. I've used React previously, and Svelte seems to be the new hot thing, so I thought I'd give it a shot.

I immediately got caught up in the Monorepo trap though. In the sense that I was spending a lot more time trying to set
up the foundation for my code (`pnpm` with `SvelteKit`) instead of just... writing the code itself. A quick `rm -rf`
later, I used the default SvelteKit create command and could *finally* could get started.

## Giving Up On My Frontend Dreams

A bit of a disclaimer, this was my first time working with SvelteKit, and so I was bootstrapping most of my progress
with some ChatGPT conversations and the [official docs](https://kit.svelte.dev/docs/introduction).

I could not for the life of me figure out how to import a CSV into my SvelteKit project. I tried following Chat's
advice which was something like:

> In your App.svelte or a relevant parent component, you can fetch and parse the CSV data.

My inner backend engineer was like "okay, that makes sense" and I spent a solid hour toiling trying to make it work. The
app could just not find the CSV file in the directory that I said it was in. I tried the `static` and `public` folders
to no avail. Was the `fetch` API even meant to work with local files?

Well, I chalked it up to CSVs not being a supported file format for local imports and just moved on.

As I reflect on this, the right way to have done this would be to have used a file input and select the file from my
machine. This is what I would have ended up needing to do anyway...

After taking on a string of L's so far, I *really* needed a win. So I just settled onto thinking about the backend.

## Servers Are Expensive

This was very much a for-fun project, and I didn't want to accrue any of the costs associated with running a server. My
experience working on another project ([Fixed-Term-Track](/projects/fixed-term-track/)) made me realize that I wasn't
really going to have much luck on the free server hosting side of things. A cheap VPS would work, but I decided against
it since I estimated some *very* light workloads.

I was 'sort of' aware of how SvelteKit basically ran its own server, but at the time it didn't hit me that I could use
it for all the processing I needed to do[^1].

This seemed like a pretty good time to work with serverless functions. I logged into the AWS console. Triple-checked
that Lambdas had a pretty generous forever-free
tier ([link](https://aws.amazon.com/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all&all-free-tier.q=lambda&all-free-tier.q_operator=AND))
and got to building.

## The Steps

The whole flow was pretty simple. I basically wanted to:

1. Parse the Goodreads CSV export
2. Parse individual fields to make sure I wasn't storing any problematic data
3. Get a valid cover image for each book
4. Store all of this data in a persistence layer
5. Notify the user via email that their bookshelf was ready for `lens`ing[^2]

## The Easy

The first two steps were pretty straightforward. I used the [csv-parser](https://www.npmjs.com/package/csv-parser)
library and basically wrote simple parser logic for each field. Something like, making sure a `Book Rating` was between
`0-5` or a `Date Read` was in a valid format and not in the past.

For the fourth step, I decided to use [Supabase](https://supabase.com/) to get access to a free Postgres database. I
manually created the table schemas[^3] I needed and was able to store data into the tables by
using [Knex.js](https://knexjs.org/) in my Lambda.

## The Hard

Retrieving the cover image was the trickiest part. After all, the end goal was to build an app that basically presented
a pretty bookshelf of your books. I absolutely **needed** these cover images, else I'd end up with some ugly info
dump.

I looked for publicly available APIs that could help me on this.
The [Open Library Developer API](https://openlibrary.org/developers/api) and
the [Google Books API](https://developers.google.com/books) seemed like my best bets. I played around with both APIs for
a bit trying to see if they 'consistently' worked. In the case of Open Library, they exposed an API to search up a cover
image based on a number of fields, an IBAN being the one I had access to as a result of the exported data.
Unfortunately, the results of my testing show me that the API wasn't consistent and I couldn't get a cover image for
every book. Either because the IBAN wasn't registered, or perhaps it was but ultimately under a different IBAN that I
had no easy way of looking up.

Y'know what would have been the best case scenario? If Goodreads themselves exposed an
API. [Oh, and they did expose such
an API at some point but deprecated it](https://www.goodreads.com/api) :)))

In classic developer fashion, I decided to hearken back to the good old days and scrape the damn
data off the webpage for each. I used [cheerio](https://github.com/cheeriojs/cheerio), an HTML/XML parser to get load
the book page, then search for the image element (ah the good 'ol `cmd + option + I` trick) and extract the URL.

It worked like a charm, but is now the biggest performance bottleneck in the project. Seems like parsing an HTML page is
a bit of an expensive computational task. Perhaps I'll consider rewriting my Lambda in Golang to see if it would make a
difference.

## The E-Mails

So the underlying assumption was that when the user uploads the CSV through the website, they'd also pass an email
address. I could then use the e-mail address to notify them of when things were done processing and could be viewed.

I mean, I thought it'd be pretty easy. After all, I had my own domain set up. There were plenty of providers online that
would allow me to send a few e-mails for free. Piece of cake. Right? Right...?

I tried a couple. [SendGrid](https://sendgrid.com/en-us) at least let me sign up for a free account. But then even after
verifying my domain, I just could not get their API to work. Tried [Brevo](https://www.brevo.com/) after hearing good
things about them. I proceeded to register only to log in and see that my account had been disabled because it was
suspicious. Right.

[AWS SES](https://aws.amazon.com/ses/) was the last thing I tried. I was able to send an e-mail after verifying my
domain. Although, they needed me to submit an official request to get out of sandbox mode. Procedurally that made sense,
but given that I didn't have a website for the project, it was pretty hard to answer their questions seriously.

After a bit of reflection on the nature of life and the purpose of e-mails in this project, I decided this was for the
best. People wouldn't feel comfortable sharing their e-mail addresses with a random website, and I wanted to make keep
things as low-friction as possible.

I could make do without sending e-mails.

## Splitting The Work

At first, I split the entire process into three Lambdas. One to parse the CSV into a JSON. One to load the cover images
into S3 while another recorded the JSON data into postgres. The goal was to parallelize the work where I could, since
ultimately the number of lambdas didn't matter as much as compute and space usage (which is what I would be charged on
anyway). Those would, arguably, be the same when comparing between the parallel and serial executions. I just needed
things to be fast so ensure a better user experience.

The problem here was that I was using S3 notification triggers to spin up the Lambdas. For example, when you upload your
CSV through the website, it would store in an S3 bucket which then triggers the first Lambda.

Similarly, once the JSON is created and stored into S3, the other two Lambdas were meant to be triggered. But apparently
I couldn't get two distinct Lambdas to trigger off the exact same S3 event. There are ways to get something like this
working (obligatory stack
overflow [post](https://stackoverflow.com/questions/70354114/trigger-multiple-lambda-on-single-s3-object-upload-event)),
but they were more cumbersome, and I was lazy.

I decided to go with two Lambdas (now that I think about it, I could probably get away with one). A few hours of testing
and making 100% sure I wasn't going to trigger a Lambda loop effect, and voilà, I was done with my serverless
backend.

## On a Tangent

I'm writing these developer logs a little later than I should have. I've already got the website up and running, so if
you're interested in seeing a working product (but not fully polished yet!) please check it out
here: [BookLens](https://booklens.msmur.dev/).

[^1]: A pretty interesting tangent all things considered. After all, when deploying an SSR frontend sites like Vercel
don't really tell you how powerful that first S is (or maybe they do – something to dig into later).
[^2]: *I'm sorry okay*. I kinda need to convince myself that the choice of the project made sense @_@
[^3]: Plural yes! Part of why I didn't go the NoSQL route. More on this on a future devlog.
