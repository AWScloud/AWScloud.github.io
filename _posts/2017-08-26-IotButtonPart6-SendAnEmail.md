---
layout: post
title:  "IoT Button Part 6 - Send an email"
date:   2017-08-26 01:35
comments: false
description: "IoT Button Part 6 - Send an email"
categories: 
    - AWS
tags: 
    - AWS
---

We tested that our button is sending data to AWS IoT and now is time to extend this info to the world. First what I tested was sending of email to my work address. We will use [Simple Notification Service](https://aws.amazon.com/sns/) for email forwarding. In general, we will have the flow same as from this picture:

![IoT Flow big](https://media.amazonwebservices.com/blog/2017/IoTEnterprise-18-IoTExampleArchitecture-sm.png)

Lambda is a topic for one of upcomming articles where we will connect to Visual Studio Team Services.

## SNS

We need to create SNS topic first. Let's go to **SNS** in AWS Console and choose **Topic**. Create topic and give it some good name.

![Create topic](/img/iot-topic.png)

![Topic name](/img/iot-topicname.png)

Click to newly created topic and click to **Create subscription**. Choose _Email_ as protocol and write your mail.

![Topic subscription](/img/iot-subscription.png)

Now you created SNS topic to which we will send our messages.

## Rule

Now, go to AWS IoT Dashboard and chose **Rule**. Click **Create**, give it the name and description.

![Rule name](/img/iot-rulename.png)

Then in _Message source_ part select condition where the rule will do its action. For me, it's this:

![SQL rule](/img/iot-rulemessagesource.png)

You see that as you type in text boxes, SQL query is build in _Rule query statement_ box. My final SQL rule is: `SELECT * FROM 'iotbutton/G0xxxxN' WHERE clickType = 'SINGLE'`

When you defined the query, you need to add some action. Click **Add action** and choose SNS.

![SNS](/img/iot-rulesns.png)

![SNS action](/img/iot-ruleaction.png)

On the next screen configure SNS. Few notes here:

 - I choose my other policy, but you should use the one you created few seconds ago.
 - You need to assign a role which has rights to perform SNS actions. This role - in my case - is _makovecDashBRole2_ and has following parameters:
   - Attached policy with these settings:
   ```json
    {
        "Version": "2012-10-17",
        "Statement": {
            "Effect": "Allow",
            "Action": "sns:Publish",
            "Resource": "arn:aws:sns:eu-west-1:5xxxxx6:makovecDashBTopic"
        }
    }
   ```
   - so the only action is publishing to SNS topic we created.
 - If you don't have one, just click to **Create a new role** button and give it the name.

If everything is OK, you should see the rule created. And now the magic. Click your button and in few seconds you should see email in your Inbox.

![mail](/img/iot-mail.png)

And that's all for today, let's summarize it again.

![Rule flow](/img/iot-flow4.png)


