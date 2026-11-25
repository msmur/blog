---
title: "Encryption for Chezmoi"
summary: "Using 'age' For Encryption With Chezmoi"
date: "2025-12-08"
tags: [ "2025", "chezmoi" ]
categories: [ "guides" ]

toc: true
readTime: true
math: true
showTags: true
autonumber: false
hideBackToTop: false
---

## Prerequisites

1. You're already using or have a basic understanding of [chezmoi](https://www.chezmoi.io/), and want to start
   committing
   secrets / sensitive information to your chezmoi repository
2. You have [age](https://github.com/FiloSottile/age) installed

## Context

Personally, I started off using a password manager but quickly found it cumbersome to have to authorize every
`chezmoi apply` command because the secrets had to pulled and processed *when* running the command. Which... makes
sense, I wouldn't want my Terminal Emulator to have unencumbered access to my Password Manager.

Thinking about it a bit more, I realized that I didn't particularly need the secrets to be secrets when they're on my
device. I'm operating under the assumption that I can trust the device that I'm on and simply need things to stay
a secret when on my repository.

## Guide

1. Create an age key
    1. `age-keygen -o key.txt`
    2. Make sure to note the public key in the output, which looks something like: `Public key: agexxx...`
    3. `key.txt` is now your private key
2. Encrypt your private key
    1. `age -p -o key.txt.age key.txt`
    2. Make note of this passphrase, it'll be used to decrypt the encrypted file later
3. Move the encrypted private key to your chezmoi folder
4. Add the encrypted private key to your `.chezmoiignore`
5. Create the script
6. Update your `.chezmoi.toml.tmpl` with the age configuration

## What Are We Doing?

