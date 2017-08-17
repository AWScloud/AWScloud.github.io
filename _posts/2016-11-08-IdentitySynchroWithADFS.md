---
layout: post
title:  "Identity synchronization with ADFS"
date:   2016-11-08 13:00
comments: false
description: "How to use ADFS to synchronize AD identities to AWS IAM"
categories: 
    - Identity
tags: 
    - IAM
    - ADFS
    - Identity
---

## Description
When working with corporate identities, it's necessary to synchronize your internal identities to your cloud provider.
As we use Active Directory, there is a method of using these identities in AWS. It's just necessary to use 
Active Directory Federation Services (ADFS).

All steps are described [at this page](https://aws.amazon.com/blogs/security/enabling-federation-to-aws-using-windows-active-directory-adfs-and-saml-2-0/).