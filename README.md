[![Build Status](https://semaphoreci.com/api/v1/projects/c1127eeb-9c13-44dd-baeb-155ce4a54493/425379/badge.svg)](https://semaphoreci.com/fegoa89/date-manager)
# DateManager

Parse, validate, manipulate, and display dates.

# Start

DateManager is a gem for convert/parse/compare two strings into date a DateTime object and manipulate them .
For handle different dates format, I did this gem based on the most used formats in different countries (https://en.wikipedia.org/wiki/Date_format_by_country#Listing), from where I can divide it in three basic types :

- MDY - Month/Day/Year mm/dd/yyyy
- DMY - Day/Month/Year dd/mm/yyyy
- YMD - Year/Month/Day yyyy/mm/dd

# Using DateManager

Create an instance:

    $ @dates = DateManager.new('2012/02/02', '2012/02/03')

The standard string input is the YMD format .

You can set any other string input format (Like day - month - year) passing the date format as a third parameter like :

    $ @dates = DateManager.new('02/03/2015', '03/03/2015', 'DMY')

or

    $ @dates = DateManager.new('12/30/2015', '12/31/2015', 'MDY')


If the format is given as a DMY ( for example) and it does not contains a third parameter that indicates that the strings given are build on this format, the first date and the last date wont be possible to get set .
You can use a '.' , '-' or '/' as a component separator for separate the different components of the dates, it will be translated into '/'.

After a succesfull creation of an object, keep in mind the date range you are passing. The first date (first string given) should be older than the second date (second string given). If not it does not have sense (you can test it calling the method '#valid_date_range?' . The purpose of this gem is play between the dates of two dates :) )

# Methods

## start_date
Returns the start_date object :

    $ @dates = DateManager.new('02/03/2015', '03/03/2015', 'DMY')
    $ @dates.start_date
    $ #<DateTime: 2015-03-02T00:00:00+00:00 ((2457084j,0s,0n),+0s,2299161j)>

## finish_date
Returns the finish_date object :

    $ @dates = DateManager.new('02/03/2015', '03/03/2015', 'DMY')
    $ @dates.finish_date
    $ #<DateTime: 2015-03-03T00:00:00+00:00 ((2457085j,0s,0n),+0s,2299161j)>

## format
Returns the date format :

    $ @dates = DateManager.new('02/03/2015', '03/03/2015', 'DMY')
    $ @dates.format
    $ DMY

## valid_date_range?

Compares if the first string given is a date older than the second string given .

    $ @dates = DateManager.new('02/03/2015', '03/03/2015', 'DMY')
    $ @dates.valid_date_range?
    $ true

## days_between_dates

Gives back the quantity of days between these dates

    $ @dates = DateManager.new('02/03/2015', '03/03/2015', 'DMY')
    $ @dates.days_between_dates
    $ 1

## months_between_dates

Gives back the quantity of months between these dates

    $ @dates = DateManager.new('02/02/2015', '03/03/2015', 'DMY')
    $ @dates.months_between_dates
    $ 1

## years_between_dates

Gives back the quantity of years between these dates

    $ @dates = DateManager.new('03/03/2014', '03/03/2015', 'DMY')
    $ @dates.years_between_dates
    $ 1

## start_date_leap_year?

Returns true or false depending if the start_date object is a leap year or not
    $ @dates = DateManager.new('03/03/2014', '03/03/2015', 'DMY')
    $ @dates.start_date_leap_year?
    $ false

## finish_date_leap_year?

Returns true or false depending if the finish_date object is a leap year or not

Gives back the quantity of years between these dates

    $ @dates = DateManager.new('03/03/2014', '03/03/2016', 'DMY')
    $ @dates.finish_date_leap_year?
    $ true

## differences_between_dates

Returns a hash containing the quantity of years / months / days between the dates

    $ @dates = DateManager.new('03/03/2014', '03/03/2016', 'DMY')
    $ @dates.differences_between_dates
    $ {:years=>2, :months=>24, :days=>731}

## readable_days_between_dates(language = {})

Returns a string with quantity of days in between. Only Spanish and English are supported.

    $ @dates = DateManager.new('02/02/2015', '03/03/2015', 'DMY')
    $ @dates.readable_days_between_dates
    $ 29 days

## readable_months_between_dates(language = {})

Returns a string with the quantity of months in between. Only Spanish and English are supported.

    $ @dates = DateManager.new('02/02/2015', '03/04/2015', 'DMY')
    $ @dates.readable_months_between_dates
    $ 2 months

## human_readable_format

Returns a string with start_date and finish_date object in a human readable way . Only Spanish and English are supported.

    $ @dates = DateManager.new('2012/02/01', '2012/02/03')
    $ @dates.human_readable_format
    $ "First date : February 01, 2012 Wednesday - Second date : February 03, 2012 Friday"

## working_days

Return quantity of working days between dates

    $ @dates = DateManager.new('2012/02/01', '2012/02/03')
    $ @dates.working_days
    $ 3

## total_weekend_days

Return quantity of saturdays / sundays between dates

    $ @dates = DateManager.new('2015/01/30', '2015/02/13')
    $ @dates.total_weekend_days
    $ 4

# Installation

Add this line to your application's Gemfile:

    gem 'date_manager'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install date_manager


# Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
