---
title: "BookLens | Devlog #2"
summary: "Better yet"
date: "2024-10-06"
tags: [ "frontend", "sveltekit", "ux"]
categories: [ "devlogs" ]

toc: true
readTime: true
math: true
showTags: true
autonumber: false
hideBackToTop: false
---

So I had been able to 'parse' my Goodreads export and get it into a format that I could work with. This data was also
now in a database, so I could work with simply querying it instead of having to suffer through more shenanigans.

I only needed two pages. A **Home** page where users would be able to get an idea of what the website was about, and
upload their own export! The other page was the "Bookshelf" page which would display the books of the user's export.
This one wasn't really a single 'page' per se. I had to make it a route, the path parameter of which would indicate
which user's bookshelf to display.

Something simple like: `/:bookshelf-id`

With that settled, I got started with designing this bookshelf page. I mean, I had my data already processed, so it was
more fruitful to figure out how to display the information first.

I don't really have any formal experience in UX or Design, so I just went with what I thought 'looked good.' This ended
up just being a simple grid, with each grid item being the cover image followed by some of the easily displayable
information I processed from the exports. The fields were: Title, Author, Rating, Number of Pages, and Date Read.

With ChatGPT's help, it was fairly easy to get things up and running. I... unfortunately, didn't take a screenshot of
how it looked back then. But it was 'good enough.'

There were a couple of interesting takeaways from this experience, though:

1. Initializing the Database Connection
2. Feigning a 'Processing' UX State
3. Client and Server-side rendering

## Initializing the Database Connection

It wasn't too difficult to figure out *what* I needed to do to get the database connection working. There was plenty of
that across various reddit threads I followed. The tricky bit was wrapping my head around how the SvelteKit 'server'
functions. I was using the Node.js adapter, so it was clear that there was some server constantly running. The
SvelteKit [hooks](https://kit.svelte.dev/docs/hooks) API was how SvelteKit allowed me to interact with the server.

It's a pretty straightforward read and while the terminology of a 'hook' was initially a bit confusing for me, given my
experience with React 'hooks,' I internalized it quite well once I likened SvelteKit's hooks to being middleware as
one would use in a regular web app.

The logic itself was plenty simple, here's what I did:

```ts
export const handle = (async ({ event, resolve }) => {
	const connection = connectToDB();
	event.locals = { connection };
	return resolve(event);
}) satisfies Handle;
```

The `connectToDB` function was the function that loaded in your environment variables and established a connection
to the database. In my case, I used [Knex.js](https://knexjs.org/) to connect to a postgres instance.

## Feigning a 'Processing' UX State

This one was a 



