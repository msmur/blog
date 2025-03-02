---
title: "Self Hosting with Coolify and Cloudflare"
summary: "Setting up a VPS for self-hosting applications with Coolify and Cloudflare"
date: "2025-03-02"
tags: [ "2025", "self-hosting", "cloudflare", "vps" ]
categories: [ "guides" ]

toc: true
readTime: true
math: true
showTags: true
autonumber: false
hideBackToTop: false
---

## The Prerequisites

1. Buy a domain
2. Get Cloudflare to manage your domain

If you're interested in understanding a bit more about DNS resolution (which is tangentially related), you could read
this: [DNS From Scratch](/dev/2024/dns-from-scratch/)

## The Guide

### 1. Go get a VPS

I used [Hetzner](https://www.hetzner.com/cloud). There are plenty of resources out
there that help you compare services. I've
seen [this](https://docs.google.com/spreadsheets/d/e/2PACX-1vRYARikgwMhj26rqu5k1Kpu9kjey1IBPF9LSURkoB7BYnawG9zsi5fYGmVAQrKCaNaBGcgFtOlWSSFZ/pubhtml?gid=0&single=true)
spreadsheet linked for information on cheap providers. But to name a few I've seen mentioned a lot (which is in no way
indicative of
anything but, perhaps, popularity):

- [Digital Ocean](https://www.digitalocean.com/solutions/vps-hosting)
- [Vultr](https://www.vultr.com/products/cloud-compute/)
- [Linode](https://www.linode.com/products/shared/)
- [Hostinger](https://www.hostinger.com/vps-hosting)
- [AWS Lightsail](https://aws.amazon.com/lightsail/)

### 2. Set up your VPS instance

There are some minimum hardware requirements expected by [Coolify](https://coolify.io/) you can see
them [here](https://coolify.io/docs/get-started/installation#_4-minimum-hardware-requirements).

You can typically choose an OS and a CPU architecture as you wish. I used `Ubuntu 24.04 LTS` with an `Intel` CPU for my
own. Note that, any commands to run on your terminal will assume Ubuntu with a bash shell as a consequence.

In the name of security I'd recommended you use private keys for SSH access. You can generate one with:

```bash
ssh-keygen -t ed25519
```

Follow the instructions on your terminal to complete creating the key pair, then upload a copy of the public key to your
VPS provider, they'll handle the rest.

Once you're done, take note of the public IP address of your server. I'll be using `<vps-ip>` as a placeholder for the
rest of this guide.

> [!CAUTION]
> You might be tempted to get an IPv6 only VPS (if they are offered, they are cheaper than a dual-stack VPS).
>
> You'll need to make sure your router is configured to handle IPv6 connections though.

You can edit your `~/.ssh/config` file to make it easier to SSH into the VPS later:

```
Host <name-of-your-choice>
      HostName <vps-ip>
      User root
      IdentityFile <path-to-private-key>
      IdentitiesOnly yes
```

There's a lot to say about managing your VPS and making sure it's secure and kept up to date, but that's outside the
scope of this guide. I *would* recommend you update all the packages that have updated available before moving on to the
next step.

```bash
ssh <name-of-your-choice>
apt update 
apt upgrade -y
```

### 3. Set up Coolify

This part is relatively straightforward. You can follow the Coolify installation
guide [here](https://coolify.io/docs/get-started/installation).

Once it's done installing, it'll list a URL on your terminal, something like: `<your-ip>:8000`, which you should
*immediately* navigate to because you'll be prompted to set up your admin account.

### 4. Set up Cloudflare for DNS resolution

I'm going to assume you don't want to have to access your Coolify dashboard using a raw IP address. If you do, well, you
can skip this step.

Navigate to the DNS records section of your domain on the Cloudflare dashboard. You can get there from:

> Account Home > [Click on your domain] > DNS > Records

You'll have to add an `A` record. The details would look something like:

- Type: `A`
- Name: `<subdomain-of-your-choice>`
- Value: `<vps-ip>`
- Proxy Status: `Proxied`
- TTL: `Auto`

For example, if you list your subdomain as `home`, your intention is to set `home.your-domain.com` to point to your
Coolify instance.

Then, navigate to `/settings` on your Coolify dashboard and set the `Instance's Domain` property to be the same value as
the subdomain you just created a record for. Which, in this example, would be `home.your-domain.com`.

Two other things to note:

Set the SSL/TLS encryption mode to `Full (Strict)`, you can find it under `SSL/TLS` in your Cloudflare dashboard for
the relevant domain. As for why this is important... well, to be completely honest I'm not sure. Only that the DNS
resolution didn't work for me with the default settings.

Under `Security > WAF` you can set up a custom rule to limit access to the above address to only your IP address. The
expression would look something like:

```
(not ip.src in {<home-ip>} and http.host in {"<home.your-domain.com>"})
```

I use an array for both values so you can extend the selection as you wish.

### 5. Go wild~

You can then proceed to do play around with Coolify. You can give each of your self-hosted applications
their own domain through the Coolify dashboard for the application's configuration page. It would be something like:
`https://<app-name>.your-domain.com:<port>` where `<port>` is the port the application is running in.

You'll then have to create another `A` record for `app-name` in the Cloudflare dashboard.

If it's meant to be a private application, you can update your Cloudflare WAF rule to include the new domain.

There's definitely other ways to handle security and access related concerns, like Cloudflare Tunnels which Coolify has
a guide on
here: '[Coolify - Cloudflare Tunnels](https://coolify.io/docs/knowledge-base/cloudflare/tunnels/overview)' *or* settings
up access through only a VPN. Neither of which I've yet to try to figure out!

