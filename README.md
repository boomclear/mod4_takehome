# Tea Subscription API

### Database Schema:
https://dbdesigner.page.link/rm8imwDVw2Z4D6AK8

## JSON Contract

POST /api/v1/subscribe
This route will create a new subscription for a customer and tea
Payload Request: 
```
{
  "tea_name": "Oolong",
  "email": "austin@gmail.com",
  "monthly_fee": 12.99,
  "frequency": "monthly"
}
```
Payload Response: 
```
{
    "data": {
        "id": "2",
        "type": "subscription",
        "attributes": {
            "subscription_id": "8232b9c27c401476a1a35bd6a02f0685",
            "monthly_fee": 12.99,
            "status": "active",
            "frequency": "monthly",
            "tea": "Oolong",
            "customer": "austin@gmail.com"
        }
    }
}
```
DELETE /api/v1/subscribe
This route will cancel a subscription for a customer and tea

Payload Request: 
```
{
  "subscription_id": "8232b9c27c401476a1a35bd6a02f0685"
}
```
Payload Response: 
```
{
    "data": {
        "id": "2",
        "type": "subscription",
        "attributes": {
            "subscription_id": "8232b9c27c401476a1a35bd6a02f0685",
            "monthly_fee": 12.99,
            "status": "cancelled",
            "frequency": "monthly",
            "tea": "Oolong",
            "customer": "austin@gmail.com"
        }
    }
}
```
POST /api/v1/subscriptions
This route will give you all the subscriptions a customer currently has

Payload Request: 
```
{
  "email": "austin@gmail.com"
}
```
Payload Response:
```
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "subscription_id": "95704b22c66b55b1648d61a81802b07b",
                "monthly_fee": 12.99,
                "status": "cancelled",
                "frequency": "monthly",
                "tea": "Oolong",
                "customer": "austin@gmail.com"
            }
        }
    ]
}
```

## Ruby and Rails Version

ruby 3.2.2
rails 7.0.7

Gems can be found in the Gemfile

## Setup

install ruby 3.2.2 instructions can be found at https://www.ruby-lang.org/en/documentation/installation/

install bundler, bundler can be found at https://bundler.io/

after installing bundler run command `bundle` in terimal while in the root directory of this project

Go to root directory of this project and run `rails s` to boot up a virtual server that you can make requests to

## Testing

To run tests first go through setup then run `bundle exec rspec` in terminal while in the root directory
