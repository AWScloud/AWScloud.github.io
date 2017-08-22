---
layout: post
title:  "IoT Button Part 2 - What we will use"
date:   2017-08-22 01:01
comments: false
description: "IoT Button Part 2 - What we will use"
categories: 
    - AWS
    - IoT
tags: 
    - dash
    - button
---

When worked with IoT Button I touched following AWS technologies:

- AWS IoT
- MQTT
- SNS
- SES
- S3
- Lambda
- IAM

It is pretty good list and it proved my golden rule - when I want to learn something, best thing is to play with it on some real life example.

During following articles I'd like to talk about every part, not to mention some addition technologies I touched, for example Python language or Visual Studio Team Services.

## What is my target

When I started I had an easy task ahead of me:

1. Set up the button
2. Test manually via Management portal
3. Send mail to my Inbox
4. Create something useful ;)

The _useful_ point - I was thinking about different tracking options where I just click once at the beginning and twice at the end. But then I had a discussion with the client and found perfect example.

As I am mostly Microsoft Azure guy, our projects are tracked in [Visual Studio Team Services](https://www.visualstudio.com/team-services/). With this client we do some DevOps scenarios where everything from application (in-house developped) to the infrastructure (Azure IaaS and PaaS) is tracked there. When we were planning demonstration of this principle to management, I decided that whole build/release cycle will be started by single click of Amazon IoT Button :) So we will nicely connect two cloud leaders into one process.

