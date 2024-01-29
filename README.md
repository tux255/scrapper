# Scrapper service

* Ruby: 3.2.1

* System dependencies:
  xvfb required

* Database:
  no database used

* How to run the app:
  rails s

* How to run the test suite:
  rspec spec/

* Services:
  file_store cache enebled for DataController#perform

* Payload for manual testing via Postman:
```
{
  "url": "https://www.alza.cz/aeg-7000-prosteam-lfr73964cc-d7635493.htm",
  "fields": {
    "meta": ["keywords", "twitter:image"],
    "price": ".price-box__price",
    "rating_count": ".ratingCount",
    "rating_value": ".ratingValue"
  }
}

{
  "url": "https://en.wikipedia.org/wiki/List_of_tz_database_time_zones",
  "fields": {
    "meta": ["format-detection","referrer"],
    "headline": ".mw-headline"
  }
}
```