# SolMap
*Finding attractive solar markets via chloropleth map visualization of utility data and solar irradiance across the US*

This project was created in 8 hours as part of SfunCube's Solar Hackathon 2015.

*"SfunCube's Solar Hackathon brings the Bay Area’s most hardcore developers, creative designers, and brilliant solar business minds together to accelerate solar adoption in the US and around the world"*

Sponsors: 11th Hour Foundation, Enphase Energy, Sungevity, Sunrun, Hanergy, Genability, Nest.

![SolMap](http://res.cloudinary.com/drd0r2vfh/image/upload/v1429554223/Screen_Shot_2015-04-20_at_11.12.22_AM_job8zw.png)

##Inspiration

We wanted to create a simple tool for solar companies to target potential solar customers. SolMap pulls data from a variety of sources in order to determine the most attractive solar markets in the country and display it in an attractive way.

##How it works

We use the Genability API and the Nrel API to collect data on counties. We sort counties based on their DNI (direct normal irradiance) and by average annual utility cost for residents.  Darker shaded counties signify those with the highest costs.

High utility costs plus good DNI means that a customer could save a lot of money by switching to solar.

##Challenges:

Consuming Genability's API was difficult because it was so new.  We were able to eventually get the data that we needed, but searching through documentation to find what we needed took a lot of our time.

We were dealing with a HUGE amount of data.  Sorting through every zip-code/county in the U.S. meant there was little room for error.

##Accomplishments:

We were able to pitch and demo our working MVP after 8 hours of work.

##What we learned

It was our first time using new technologies such as D3.js, and 2 new API's. We also learned about a whole new industry that none of us had any previous experience in.

##What's next for SolMap

Because of time and API constraints, we only seeded data for the state of California (all 43,000 zip codes in the U.S. would have eaten too much time).  We are hoping to apply data to all counties across the country and deploying a live version of the app.

Built With: Ruby on Rails, JavaScript, jQuery, D3.js, NREL API, Genability API.

Team: Ricky Chen, Brain Lin, Zac Barnes, Andy Macedo, Evan Hughes
