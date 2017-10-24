---
layout: post
title:  "IoT Button Part 7 - Prepare Lambda function"
date:   2017-08-29 11:38
comments: false
description: "IoT Button Part 7 - Prepare Lambda function"
categories: 
    - AWS
    - IoT
tags: 
    - dash
    - button
---

You successfully configured your Button to send an email. Now let's have a look to some more advanced scenario. We will call Lambda function. Then it is up to you what your Lambda will do. As I mentioned earlier, I'll show you example how to call start of new Build (think CI/CD) in Visual Studio Team Services (VSTS).

## Lambda functions

Lambda is AWS way of serverless compute. At the moment you can use following languages in your Lambda functions:

- Node.js
- Python
- C#
- Java

In general - you'll write a function (you can do that directly in AWS console) and AWS will run it in background. Functions has to have defined structure as described [here](http://docs.aws.amazon.com/lambda/latest/dg/programming-model-v2.html?shortFooter=true).

During my IoT Button testing I did a review of [Manning publication](https://www.manning.com/) book [Get Programming: Learn to code with Python](https://www.manning.com/books/get-programming) so I decided to use Python as much as possible. Thats the reason why I used Python here. Normally I would use C# for all my codes.

## Create a function

Open AWS console, go to Lambda section and click **Create function**. You can use authoring from scratch or use _Blueprint_ which is like template for specific action. For start you can use `hello-world-python` blueprint which is a started for Python functions.

Give the name to the function and create a role for running lambda function from template. You can do it from template or you can use your own. My role is shown here:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "sns:Publish"
            ],
            "Resource": "arn:aws:sns:eu-west-1:123456789196:makovecDashBTopic"
        }
    ]
}
```

This role ensures that lambda function is able to publish data to previously created SNS topic.

### Code description

Below is the code I use for running build in Visual Studio Team Services. It basically loads all necessary libraries (with `import`) and then in `lambda_handler` (which is default name for entry point) I assigned all necessary variables, converted credentials `base64.b64encode(bytes(myString))` and then accessed the RESP API endpoint to run given build (BuildID = 9).

VSTS REST API is described at [Overview page](https://www.visualstudio.com/en-us/docs/integrate/api/overview). In the documentation I simply checked how to [queue a build](https://www.visualstudio.com/en-us/docs/integrate/api/build/builds#queue-a-build) and changed it to my example. 

```python
from __future__ import print_function

import json
import urllib2
import base64
import os

print('Loading function')

def lambda_handler(event, context):
    
    vstsAccount = "myVSTSaccount"
    projectName = "Flexi Sandbox"
    user = ""
    token = os.environ['PATstring']
    myString = "%s:%s" % (user,token)
    data = {
        'definition': {
            'id': '9'
        }
    }
    
    base = base64.b64encode(bytes(myString))
    print(base)

    request = urllib2.Request(os.environ['VstsUri'])
    base64string = base64.encodestring('%s:%s' % (user, token)).replace('\n', '')
    request.add_header("Authorization", "Basic %s" % base64string)   
    request.add_header('Content-Type', 'application/json')
    result = urllib2.urlopen(request, json.dumps(data)).read()
    return result
    
```

There are few techniques in previous list. First of all - I used **Environment variables**, you can see them under the box with the code itself.

![Lambda function env vars](/img/iot-lambdaenvvar.png)

You can use environment variables when you don't want to hardcode some strings into the code itself. In my example - I use it for storing URI path to my VSTS project and for storing Personal Access Token (password to access VSTS). These environments are accessible from the code with following line:

```python
token = os.environ['PATstring']
```

`os.environ[xxx]` loads the text and in previous example I am immediately storing it to variable named `token`.

## What we did today

We created Lambda, role and push the data from lambda to SNS topic.

![Flow Lambda](/img/iot-flow5.png)