---
layout: post
title:  "IoT Button Part 5 - Test connection"
date:   2017-08-25 01:47
comments: false
description: "IoT Button Part 5 - Test connection"
categories: 
    - AWS
    - IoT
tags: 
    - dash
    - button
---

So we prepared AWS console and set up the button to send some messages. Now let's check how to test if everything works fine.

## MQTT client

In AWS IoT there is a Test menu, where you can use MQTT client directly for quick test.

![MQTT client](/img/iot-mqtttest.png)

First of all we need to subscribe to the topic. It is pretty straightforward. Click to the box below **Subscription topic** and fill the info about your button. You can write it in (basically) two ways:

* With wildcard: `iotbutton/+`
* Directly to your button: `iotbutton/<yourDSN>`

Click to **Subscribe to topic** and you will see it's accepted.

![MQTT subscription](/img/iot-testsubscribe.png)

Now is the time to confirm that everything you did was correct. **Click to your button**. Button will blink white and then you'll see green light. In a second you should see the message in MQTT client:

![MQTT click subscription](/img/iot-mqttclick.png)

Voila :) In the pane you see JSON sent by the IoT button. It contains three fields:

* `serialNumber` which is pretty clear
* `clickType` should be SINGLE, DOUBLE, LONG as the button supports three types of clicks
* `batteryVoltage` in [mV]

This is what we did in this post.

![Test flow](/img/iot-flow3.png)

So, it's the end of our test. Now we can do something more useful with the button.



