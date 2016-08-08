---
layout: default
title: CS 4400 - Summer 2016 Project
---

# Trip Planner

You will create a database for an application that allows users to explore the attractions in a given city and create a trip plan that lists all the attractions they will see during a trip to that city. The general description below describes the data your database will need to maintain and the constraints your database must enforce, in some cases with application code.

Phase 1 example EER: [trip-planner.svg](trip-planner.svg)

## General Description

A user account is required to access the trip planning system, so the database must maintain user account information such as a user's name and email address. Some users will have administrative rights to the system in order to add attractions, update attraction information, and get reports of an attraction's rosters and schedules. An admin user will also have the ability to add and delete user accounts and place user accounts on hold if abuse is detected (see section on reviews below).

An Attraction is some place that a visitor would want to visit. An attraction could be a tour, a monument, a public park to hang out in, or any other place of note in a city. Some attractions have a fee, and some are free. Some attractions require reservations for a particular time slot and have bounded durations. At a minimum the database will need to maintain attractions' names, addresses, descriptions, hours of operations, and nearest public transportation so that users (or the trip planning system) can plan trips appropriately. Attractions that require reseravations or have times slots and bounded durations will need to keep track of the data necessary for planning them, including the number of spaces available for each time slot.

A trip is a list of activities in a city. A user plans a trip to a city by selecting attractions for each day of their visit and adding these to their trip as activities. An activity is a visitor's visit to an attraction on a trip. Where appropriate, a trip's activities will include reservations for attractions that require them. Reservations will include the attraction, data, start time and end time, and a reservation number. The system should ensure that activities do no overlap, and may enforce a travel time gap between activities to ensure that users can make it from one activity to the next.

Once a user has completed a trip plan, the user can purchase reservations included in the trip. The system should collect and store credit card information from the user, using one of the user's addresses as the billing address. At time of purchase the system should ensure that space is still available for each activity in the user's trip. Once the purchase is completed, spaces for the apporpriate time slots for those attractions should be updated. If a time slot at an attraction becomes sold out before a user completes their purchase of a trip itinerary, the system should remove that activity from the user's trip, exit the trip purchasing process, and allow the user to update their trip plan.

Once a user has completed a trip, which the system knows simply by the fact that the end date of the trip has passed, the user can create a review for attractions included in the completed trip. The system should ensure that only users can only add revies for attractions that were included on trips that they completed.

## Summary of Data

User

- Name
- Address
- Email address

Admin User

- Name
- Address
- Email address

Attraction

- Name
- Address
- Description
- Hours of operation
- Nearest public transportation
- Times slots (where applicable)
- Price (where applicable)

Reservation

- Attraction
- Date
- Start Time
- End Time

Trip

- Start and end times
- Activities
- Total Cost
- Booked (purchase completed)

Credit Card

- User
- Credit card number
- Expiration date (Month and Year)
- Billing address

Review

- User
- Attraction
- Title
- Body


## Phase 3 Requirements

Turn in two SQL files: `teamN-data.sql` and `teamN-queries.sql`.

**`teamN-data.sql`**, where `N` is your team number, should contain valid SQL code to insert data into your database tables for at least 3 attractions in each of 3 cities, including Metz, Paris, and one or more cities of your choosing. There should be data for each field for each row in each table, including the descriptions of the attractions (the descriptions should be correct, but don't have to be longer than two sentences). In addition, include insert statements to create a trip in Paris on Saturday, 30 July 2016 with at leat 3 activities, at least one of which requires a reservation and at least two of which requires payment (they can be the same activity).

**`teamN-queries.sql`**, where `N` is your team number, should contain valid SQL code for queries that answer the following questions:

- Given a username or email address, is that user in the database?
- Given a username or email address, is that user an admin user?
- Which attractions are open right now in Paris?
- Which attractions in Paris don't require reservations?
- Which attraciotns in Metz are free?
- Show the details for one attraction?
- List all the reviews for an attraction.
- List all the reviews written by a particular user.
- Show the details of one review.
- List the trips in the database for a particular user.
- For an attraction that requires reservations and already has some reservations for a time slot, how many spots remain for that time slot?
- For one of the trips in the database that has two more more paid activities, what is the total cost of the trip?
- For one of the public transportation locations in your database, which attractions are nearest to that location (list it as the nearest public transportation)?


<!--

## UI Mockups

User log's in.
<div class="panel panel-default">
<div class="panel-heading">
<h3 class="panel-title">Sign in</h3>
</div>
<div class="panel-body">

<form class="form-horizontal">

<div class="form-group">
<label for="username" class="col-sm-2 control-label">Username</label>
<div class="col-sm-10">
<input type="username" class="form-control" id="username" placeholder="">
</div>
</div>

<div class="form-group">
<label for="password" class="col-sm-2 control-label">Password</label>
<div class="col-sm-10">
<input type="password" class="form-control" id="password" placeholder="Password">
</div>
</div>

<div class="form-group">
<div class="col-sm-offset-2 col-sm-10">
<button type="sbumit" class="btn btn-default">Register</button>
<button type="submit" class="btn btn-default">Sign in</button>
</div>
</div>
</form>

</div>
</div>

User dashboard listing existing trips.
<div class="panel panel-default">
<div class="panel-heading">
<h3 class="panel-title">Arcot Ramathorn</h3>
</div>
<div class="panel-body">

<form class="form-horizontal">

<div class="form-group">
<label for="username" class="col-sm-2 control-label">Username</label>
<div class="col-sm-10">
<input type="username" class="form-control" id="username" placeholder="">
</div>
</div>

<div class="form-group">
<label for="password" class="col-sm-2 control-label">Password</label>
<div class="col-sm-10">
<input type="password" class="form-control" id="password" placeholder="Password">
</div>
</div>

<div class="form-group">
<div class="col-sm-offset-2 col-sm-10">
<button type="sbumit" class="btn btn-default">Register</button>
<button type="submit" class="btn btn-default">Sign in</button>
</div>
</div>
</form>

</div>
</div>
-->