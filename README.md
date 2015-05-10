/# DateManager

> Work in progress, This gem is not finalized yet.

Parse, validate, manipulate, and display dates.

# Start

DateManager is a gem for convert/parse/compare two strings into date a DateTime object and manipulate them .
For handle different dates format, I did this gem based on the most used formats in different countries (https://en.wikipedia.org/wiki/Date_format_by_country#Listing), from where I can divide it in three basic types :

MDY - Month/Day/Year mm/dd/yyyy
DMY - Day/Month/Year dd/mm/yyyy
YMD - Year/Month/Day yyyy/mm/dd

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
Returns the start_date object
    $ @dates = DateManager.new('02/03/2015', '03/03/2015', 'DMY')
    $ @dates.start_date
    $ #<DateTime: 2015-03-02T00:00:00+00:00 ((2457084j,0s,0n),+0s,2299161j)>

## finish_date
Returns the start_date object
    $ @dates = DateManager.new('02/03/2015', '03/03/2015', 'DMY')
    $ @dates.finish_date
    $ #<DateTime: 2015-03-03T00:00:00+00:00 ((2457085j,0s,0n),+0s,2299161j)>

## format
Returns the date format
    $ @dates = DateManager.new('02/03/2015', '03/03/2015', 'DMY')
    $ @dates.format
    $ DMY

## valid_date_range?

Compares if the first string given is a date older than the second string given .

    $ @dates = DateManager.new('02/03/2015', '03/03/2015', 'DMY')
    $ @dates.valid_date_range?
    $ true

# Installation

Add this line to your application's Gemfile:

    gem 'date_manager'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install date_manager

# Usage

TODO: Write usage instructions here

# Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request