---
layout: exercise
title: CS 4400 - Summer 2017 Project
---

# Super Nouveaux Chemins de Fer Français (SNCF)

<center>
<img src="https://upload.wikimedia.org/wikipedia/commons/5/57/Carte_TGV.svg" height="400px" />
</center>

You are a database developer at [SNCF](http://www.sncf.com/), the French national rail company. Management has decided to implement a new train reservation system for customers that not only allows customers to book trips and administrators to edit routes, but allows management to enter trains that are cancelled due to strikes by the [CGT](http://www.cgt.fr/) and have customers' trips automatically rerouted.

## User Interface (UI) Mock-up

Following is a list of mockups of the screens that make up the database application (the user documents, using terminology from our [conceptual design process](../slides/conceptual-design-process.pdf)), with UI flow arrows and textual descriptions. You can derive an EER diagram, semantic constraints, information flow diagram, relational model, SQL statements, and the application itself from these mock-ups and descriptions. Please note that these are low-fidelity mock-ups. Your UI will likely (and probobly should) look different.

### Login

<table>
<tr>
<td width="50%" valign="top">
<img src="login.png" alt="Login Screen" width="100%" />
</td>
<td width="50%" valign="top">
A user account is required to access the system, so the database must maintain user account information such as a user's name and email address. Some users will have administrative rights to the system in order to add and edit train information -- including cancellations due to les grèves (strikes) -- and get passenger manifests.
</td>
</tr>
</table>

### Registration

<table>
<tr>
<td width="50%" valign="top">
<img src="registration.png" alt="" width="100%" />
</td>
<td width="50%" valign="top">
Items marked with a * are required.
Email is unique. Credit card is unique.
</td>
</tr>
</table>

### Administrator Dashboard

<table>
<tr>
<td width="50%" valign="top">
<img src="admin-dashboard.png" alt="" width="100%" />
</td>
<td width="50%" valign="top">
Admin can create new train routes, see passenger manifests, and set the status of a train. When the CGT strikes they cancel particular trains for particular dates. The administrator can set the status of certain trains as cancelled due to strike for specific dates, which will be reflected on all affected customer trip reports.
</td>
</tr>
</table>

### New Train (Route)

<table>
<tr>
<td width="50%" valign="top">
<img src="new-train.png" alt="" width="100%" />
</td>
<td width="50%" valign="top">
Train number is unique. Note that train number is like a flight number -- it identifies a route, not a specific physical train. Each train runs daily. For simplicity we will stipulate that all trains begin and end their routes within a single day. A train originates at a station at a time, makes zero or more stops at other stations, and terminates at a station. Passengers may embark or disembark at any stop.
</td>
</tr>
</table>

### Passenger Manifest

<table>
<tr>
<td width="50%" valign="top">
<img src="passenger-manifest.png" alt="" width="100%" />
</td>
<td width="50%" valign="top">
Admin can select legs of a route and see passenger manifest for those legs.
</td>
</tr>
</table>

### Customer Dashboard

<table>
<tr>
<td width="50%" valign="top">
<img src="customer-dashboard.png" alt="" width="100%" />
</td>
<td width="50%" valign="top">
Profile information and list of all future trips currently booked. Status of each trip shows OK or Cancellations if an legs of the trip are affected by a strike. Viewing trips details shows all legs of trip and which legs are cancelled due to strike, if applicable. Trip can then be re-routed at no additional charge.
</td>
</tr>
</table>

### Search Trips

<table>
<tr>
<td width="50%" valign="top">
<img src="search-trips.png" alt="" width="100%" />
</td>
<td width="50%" valign="top">
Search trips is where you search for and select the outbound and (optionally) return portion of a trip. A trip may be direct or may include one change of train.
</td>
</tr>
</table>

### Book Trip

<table>
<tr>
<td width="50%" valign="top">
<img src="book-trip.png" alt="" width="100%" />
</td>
<td width="50%" valign="top">
Book trip is where you add passenger information and pay.
</td>
</tr>
</table>

### Enter Passenger Infomation

<table>
<tr>
<td width="50%" valign="top">
<img src="passenger.png" alt="" width="100%" />
</td>
<td width="50%" valign="top">
The first passenger must be the user who is booking the trip. Other passengers don't need to have accounts.
</td>
</tr>
</table>

### Pay for Trip

<table>
<tr>
<td width="50%" valign="top">
<img src="pay-trip.png" alt="" width="100%" />
</td>
<td width="50%" valign="top">

</td>
</tr>
</table>

### Check Trip Status

<table>
<tr>
<td width="50%" valign="top">
<img src="trip-status.png" alt="" width="100%" />
</td>
<td width="50%" valign="top">

</td>
</tr>
</table>
