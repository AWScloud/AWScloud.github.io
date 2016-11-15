$postName = Read-Host -Prompt 'Post name'
$dateFormat = Get-Date -Format 'yyyy-MM-dd'
$postTitle = (Get-Culture).TextInfo.ToTitleCase($postName).Replace(' ','')
$postFormat = "${dateFormat}-${postTitle}.md"

$postContent = @"
---
layout: post
title:  `"$postName`"
date:   $(Get-Date -Format 'yyyy-MM-dd HH:mm')
comments: false
description: `"$postName`"
categories: 
    - AWS
tags: 
    - AWS
---

# $postName

"@ 

New-Item -Path ./_posts -Name $postFormat -ItemType File -Value $postContent -Force | Out-Null
