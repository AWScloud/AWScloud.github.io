---
layout: post
title:  "IoT Button Part 4 - Configure button"
date:   2017-08-24 02:43
comments: false
description: "IoT Button Part 4 - Configure button"
categories: 
    - AWS
    - IoT
tags: 
    - dash
    - button
---

In previous post I showed you how to prepare AWS IoT environment. Now we'll see how to prepare IoT button before first connection to IoT.

### Preparation work

During the button preparation you will need to know your endpoint. As you need to connect to AWS console, prepare it now.

1. Connect to AWS console
2. Go to **IoT/Registry/Things**
3. Select your button
4. Select **Interact**
5. In HTTPS section you'll see the endpoint

<div class=no-okraj>
![IoT endpoint](/img/iot-endpoint.png)
</div>

First part is _subdomain_ and then you see _region_ there also. Make a note about it as we will need it in few seconds.

### On the device

First of all - press the big white button for more than 5s until you will see the led blinking blue. It will start internal Wi-Fi access point with name **Button ConfigureMe - _XXX_** where _XXX_ is random generated code. You'll be asked for password which is last 8 chars from your button DSN (see the back of your button).

Connect your computer to that Wi-Fi. Then open this address in your browser: `http://192.168.0.1`. You'll see following page:

![Button ConfigureMe](/img/iot-configureme.png)

Fill following info:

* Wi-Fi SSID and password (if present)
* For Certificate and Private Key browse your computer for files you downloaded in previous post.
* Endpoint information - info you write down at the beginning of this post. As a control the whole endpoint from the beginning has to be the same as will be filled here in Final Endpoint box.
* Tick that you agree with Terms and Conditions and click continue.

Now your button will be able to connect to your Wi-Fi and send data to AWS. We will test it in next part.
