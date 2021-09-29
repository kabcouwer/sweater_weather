<!-- PROJECT INFO -->
<h1 align="center">
  <br>
  <a href="https://github.com/kabcouwer/sweater_weather">
    <img src="![weather](https://user-images.githubusercontent.com/80797707/135283412-ff5ff686-bca5-4e81-a8f1-820d9cbd8cce.jpeg)" alt="Logo" width="200" height="200"></a>
  <br>
  Sweater Weather API
  <br>
</h1>

<h4 align="center">The backend portion of a road trip application!</h4>



<!-- CONTENTS -->
<p align="center">
  <a href="#about-the-project">About The Project</a> •
  <a href="#tools-used">Tools Used</a> •
  <a href="#set-up">Set Up</a> •
  <a href="#installation">Installation</a> •
  <a href="#how-to-use">How To Use</a> •
  <a href="#database-schema">Database Schema</a> •
  <a href="#contributing">Contributing</a> •
  <a href="#acknowledgements">Acknowledgements</a>
</p>



## About The Project

A backend API for an application used to help plan road trips. This app will allow users to see the current weather as well as the forecasted weather at the destination.

### Learning Goals

* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token
* Expose an API for CRUD functionality
* Determine completion criteria based on the needs of other developers
* Research, select, and consume an API based on your needs as a developer



## Tools Used

| Development | Testing       | Gems            |
|   :----:    |    :----:     |    :----:       |
| Ruby 2.7.2  | RSpec         | Pry             |
| Rails 5.2.5 | WebMock       | ShouldaMatchers |
| JSON        | VCR           | Faraday         |
| Atom        | SimpleCov     | Figaro          |
| Github      | FactoryBot    | FastJSON        |
|             | Faker         |                 |




## Set Up

1. To clone and run this application, you'll need Ruby 2.7.2 and Rails 2.5.3. Using [rbenv](https://github.com/rbenv/rbenv) you can install Ruby 2.7.2 (if you don't have it already) with:
```sh
rbenv install 2.7.2
```
2. With rbenv you can set up your Ruby version for a directory and all subdirectories within it. Change into a directory that will eventually contain this repo and then run:
```sh
rbenv local 2.7.2
```
You can check that your Ruby version is correct with `ruby -v`

3. Once you have verified your Ruby version is 2.7.2, check if you have Rails. From the command line:
```sh
rails -v
```
4. If you get a message saying rails is not installed or you do not have version 5.2.5, run
```sh
gem install rails --version 5.2.5
```
5. You may need to quit and restart your terminal session to see these changes show up



## Installation

1. Get a free API Key at [MapQuest API](https://developer.mapquest.com/plan_purchase/steps/business_edition/business_edition_free/register)
2. Get a free API Key at [OpenWeather API](https://openweathermap.org/api)
3. Get a free API Key at [Unsplash API](https://unsplash.com/developers)
4. Fork this repo
5. Clone your new repo
   ```sh
   git clone https://github.com/{your-github-username}/sweater_weather
   ```
4. Install gems
   ```sh
   bundle install
   ```
5. Install figaro
    ```sh
   bundle exec figaro install
   ```
6. Enter your API KEYS in `application.yml`
   ```ruby
   mapquest_key: < YOUR KEY HERE >
   open_weather_key: < YOUR KEY HERE >
   unsplash_access_key: < YOUR KEY HERE >
   ```
7. Setup the database
    ```sh
   rails db:create
   rails db:migrate
   ```



## How To Use

The Sweater Weather app can be used by calling endpoints through your rails server, which will return json structured data. See these request endpoints and example responses below:



### Endpoint Documentation
All requests require `H - { Content-Type: application/json, Accept: application/json }`
<br>
#### Weather For a City
GET Request: `/api/v1/forecast?location=denver,co`

Response:
```json
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "datetime": "2020-09-30 13:27:03 -0600",
        "temperature": 79.4,
        etc
      },
      "daily_weather": [
        {
          "date": "2020-10-01",
          "sunrise": "2020-10-01 06:10:43 -0600",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00:00",
          "conditions": "cloudy with a chance of meatballs",
          etc
        },
        {...} etc
      ]
    }
  }
}
```

#### Background Image for a City
GET Request:`/api/v1/backgrounds?location=denver,co`

Response:
```json
{
    "data": {
        "type": "image",
        "id": null,
        "attributes": {
            "image": {
                "location": "denver,co",
                "image_url": "https://images.unsplash.com/photo-1619856699906-09e1f58c98b1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjM2NTl8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2MzI5MjY1MDQ&ixlib=rb-1.2.1&q=80&w=1080",
                "credit": {
                    "source": "unsplash.com",
                    "author": "rdehamer",
                    "profile": "https://unsplash.com/@rdehamer"
                }
            }
        }
    }
}
```

#### User Registration
POST Request:`/api/v1/users`

Request Body:
```json
{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

Response:
```json
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

### Login
POST Request:`/api/v1/sessions`

Request Body:
```json
{
  "email": "whatever@example.com",
  "password": "password"
}
```

Response:
```json
status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

### Roadtrip
POST Request:`/api/v1/road_trip`

Request Body:
```json
{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

Response
```json
{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Estes Park, CO",
      "travel_time": "2 hours, 13 minutes"
      "weather_at_eta": {
        "temperature": 59.4,
        "conditions": "partly cloudy with a chance of meatballs"
      }
    }
  }
}
```


## Database Schema
![sweater_weather_db](https://user-images.githubusercontent.com/80797707/135311532-4070ac28-c142-41e3-bc8b-98c9cb9c439b.png)



## Contributing

👤  **Kim Abcouwer**
- [GitHub](https://github.com/kabcouwer)
- [LinkedIn](https://www.linkedin.com/in/kim-abcouwer/)



## Acknowledgements

* [Turing School of Software and Design](https://turing.edu/)
  - Project created for completion towards Backend Engineering Program
* [MapQuest API](https://developer.mapquest.com/)
* [OpenWeather API](https://openweathermap.org/api)
* [Unsplash API](https://unsplash.com/developers)
