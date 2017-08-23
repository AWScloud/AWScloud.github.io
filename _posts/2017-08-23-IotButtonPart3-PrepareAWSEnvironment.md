---
layout: post
title:  "IoT Button Part 3 - Prepare AWS environment"
date:   2017-08-23 13:45
comments: false
description: "IoT Button Part 3 - Prepare AWS environment"
categories: 
    - AWS
    - IoT
tags: 
    - dash
    - button
---

So - you received the button, but how to set it up? 

## AWS IoT Concole
I assume you already has an AWS account, if not create one. You are good to go with AWS free tier with our examples.

![AWS IoT](/img/iot-ico.png)

### Thing
In the console go to AWS IoT. If you didn't create any resource there all menus there should contains just descriptions with buttons to create new resources. We will start with **Registry**. The button is called _Thing_ in AWS language. So click to **Things** and then to **Create**.

Give your button some name and click to **Create thing**. This will create a placeholder for your IoT Button.

![Register a Thing](/img/iot-registerathing.png)

We will not go to the optional configuration as I decided to go the easiest way with my examples.

### Policy

Next we need to create policy. Policy it telling what actions we will allow to our button. As [AWS documentaion](http://docs.aws.amazon.com/iot/latest/developerguide/authorization.html) says:

>> Policies determine what an authenticated identity can do. An authenticated identity is used by devices, mobile applications, web applications, and desktop applications. An authenticated identity can even be a user typing AWS IoT CLI commands. The identity can execute AWS IoT operations only if it has a policy that grants it permission.

Go to **Security**, choose **Policies** there and click **Create**. Give the name to your policy. 

Now we have to add statements. [Statements][iot-stat] define the action we can do with the button. Basically we need two actions:

1. `iot:Publish` for publishing on an MQTT topic.
2. `iot:Connect` for connecting message broker.

We want our button to be able to publish and different devices to connect to the message broker. Therefore we will limit the first one and allow everyone to the second one.

If you start to write to the text box under Action, you will receive list of allowed values. Set two statements.

![AWS policy statement connect](/img/iot-statementpublish.png)

![AWS policy statement publish](/img/iot-statementconnect.png)

If you will switch to **Advanced mode** you can write the statements directly in JSON format.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iot:Connect",
      "Resource": "arn:aws:iot:eu-west-1:5xxxxxxx:topic/iotbutton/G030xxxxxx"
    },
    {
      "Effect": "Allow",
      "Action": "iot:Publish",
      "Resource": "*"
    }
  ]
}
```

When done, you can click to **Create**.

### Certificate

As mentioned in [Security and Identity for AWS IoT](http://docs.aws.amazon.com/iot/latest/developerguide/iot-security-identity.html):

>> Each connected device must have a credential to access the message broker or the Thing Shadows service. All traffic to and from AWS IoT must be encrypted over Transport Layer Security (TLS). Device credentials must be kept safe in order to send data securely to the message broker. AWS cloud security mechanisms protect data as it moves between AWS IoT and other devices or AWS services.

![Security and Identity for AWS IoT](http://docs.aws.amazon.com/iot/latest/developerguide/images/thunderball-overview.png)

Under **Security** click to **Certificates** and to **Create**. We will use the easiest way.

![cert](/img/iot-cert.png)

On the next page download certificate and keys, you will need two of them later.

![Cert download](/img/iot-certdownload.png)

Click to **Activate** to - well - activate the certificate.

We can assign policy by clicking **Attach a policy** and select the one we created earlier.

![Assign policy to cert](/img/iot-assigncerttopolicy.png)

### Closing

Now we are ready to activate our IoT Button. To summarize what we did, look to following flowchart.

![flow 1](/img/iot-flow1.png)



[iot-stat]: http://docs.aws.amazon.com/iot/latest/developerguide/policy-actions.html "AWS IoT Policy Actions"
