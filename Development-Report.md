# openCX-high-on-caffeine Development Report

Welcome to the documentation pages of the *your (sub)product name* of **openCX**!

You can find here detailed information about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP): 

* Business modeling 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Architectural and design decisions]()
  * [Technological architecture]()
  * [Logical architecture]()
* Implementation
  * [Source code]()
  * [Issues](): feature requests, bug fixes, improvements.
* Test
  * [Automated tests](): Functional tests, integration tests, acceptance tests, as much automated as possible.
* Change management
  * [Issues at Github]()
* Project management
  * Tasks management tool 

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us! 

Thank you!

Gonçalo Fernandes Pereira   
Maria Gonçalves Caldeira    
Ana Rita Fonseca Santos         
Margarida Ribeiro Cosme     
Luis Miguel Guimas Marques  

## Product Vision
An app to help speakers interact with their audience in a more intuitive and fun way.
Destroy the distance between them and between the audience itself.

## Elevator Pitch
When you are presenting a session in a conference, dont you feel like the most challenging thing is to get your audience's attention, or even get them to participate? We believe with our app we can make not only conferences more interesting but also easier to interact.
You can ask questions and see what the audience answers.
Change the roles and let them submit questions over the app, and answer the highest ranked at the end. And finally let them rate you.
The better the communication, the better the message is received. 
This makes your feedback even more accurate and detailed, making it easier to know which points you need to improve at the next conference.
But our app is not only focused on breaking the distance between the speaker and the audiance, but also between the audience itself, anyone who has our app can save information from other users, so they can communicate with each other later.

## Requirements

In this section, you should describe all kinds of requirements for your module: functional and non-functional requirements.

Start by contextualizing your module, describing the main concepts, terms, roles, scope and boundaries of the application domain addressed by the project.

### Use case diagram 

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/rita/imgs/use_case2.png/)

### USER
#### Edit Account

* **Actor**: User.
* **Description**: The user can check their own account details, and edit them.
* **Preconditions and Postconditions**: In order for a user to access/edit their account data, they only need to be logged in (preconditions), any changes will be saved and updated for the next time he checks his account (postconditions).
* **Normal Flow**: 
   * The device has to be connected to the internet
   * Actor has to login/create an account
   * Actor has to select mode Participant or Speaker
   * Actor selects "Edit Account" in the app
   * Name, Country and College info are shown on the screen
   * The actor can change any information or delete it
   * He can submit the changes, and regardless of the changes he made, they are saved
* **Alternative Flows and Exceptions**:
   * Device is not connected to the internet 
      * Appears an error, not allowing the system to run
   * User changes the information but does not send it
      * Nothing is stored, so the information are the same as the last change submitted

#### Check Questions

* **Actor**: User. 
* **Description**: The user can check all the questions made by all the attendees of the conference. 
* **Preconditions and Postconditions**: For a user to be able to check questions, he/she has to be in the conference (preconditions). All questions can be checked by all conference attendees (postconditions). 
* **Normal Flow**:
   * The device has to be connected to the internet
   * Actor has to login/create an account
   * Actor has to select mode Participant or Speaker
   * Actor selects "Let'Start" in the app
   * He/she has to choose a conference and finally a session
   * In mode Participant he/she has to select "Ask Question", in mode Speaker "Check Questions"
   * In both cases, all the questions submitted associated with the session are shown on the screen, as well the email of the user that submitted it
* **Alternative Flows and Exceptions**:
  * Device is not connected to the internet 
      * Appears an error, not allowing the system to run
  * All conferences and sessions are submitted by Speakers, so it is possible that when a Participant wishes to choose, he/she will not have any

#### Check Session Rate

* **Actor**: User. 
* **Description**: The user can check the average rate that has been submitted in a specific session.
* **Preconditions and Postconditions**: For a user to be able to check rates, he/she has to be in the conference (preconditions). The average rate can be checked by all conference attendees (postconditions). 
* **Normal Flow**:
   * The device has to be connected to the internet
   * Actor has to login/create an account
   * Actor has to select mode Participant or Speaker
   * Actor selects "Let'Start" in the app
   * He/she has to choose a conference and finally a session
   * In mode Participant he/she has to select "Rate Session", in mode Speaker "Check Rate"
   * In both cases, the average rate associated with the session are shown on the screen in a format of five starts maximum
* **Alternative Flows and Exceptions**:
  * Device is not connected to the internet 
      * Appears an error, not allowing the system to run
  * All conferences and sessions are submitted by Speakers, so it is possible that when a Participant wishes to choose, he/she will not have any

### PARTICIPANT     
#### Rate Conference

* **Actor**: Participant. 
* **Description**: A participant can rate a specific session.
* **Preconditions and Postconditions**: For a participant to be rate, he/she has to be in the conference (preconditions). When a participant rate a session the average rate is calculated again (postconditions). 
* **Normal Flow**: 
   * The device has to be connected to the internet
   * Actor has to login/create an account
   * Actor has to select mode Participant or Speaker
   * Actor selects "Let'Start" in the app
   * He/she has to choose a conference and finally a session
   * In mode Participant he/she has to select "Rate Session"
   * Actor writes the rate (0-5)
   * Actor submits rate
   * The new average rate associated with the session are shown on the screen in a format of five starts maximum
* **Alternative Flows and Exceptions**:
   * Device is not connected to the internet 
      * Appears an error, not allowing the system to run
   * Participant tries to submit an empty rate or a value bigegr than 5
      * It's not possible to send empty strings or a value bigger than 5, so nothing will be submitted

#### Ask Question

* **Actor**: Participant. 
* **Description**: A participant can ask questions. 
* **Preconditions and Postconditions**: For a participant to be able to ask questions, he/she has to be in the conference (preconditions). When a participant asks a question it is visible in the application for the all users (postconditions). 
* **Normal Flow**: 
   * The device has to be connected to the internet
   * Actor has to login/create an account
   * Actor has to select mode Participant
   * Actor selects "Let'Start" in the app
   * He/she has to choose a conference and finally a session
   * In mode Participant he/she has to select "Ask Question"
   * Actor writes the question he wants to ask
   * Actor submits question
   * Question is available to everyone to see, as well the email of the user that submited it
* **Alternative Flows and Exceptions**:
   * Device is not connected to the internet 
      * Appears an error, not allowing the system to run
   * Participant tries to submit an empty question
      * It's not possible to send empty questions, so nothing will be submitted


### SPEAKER 
#### Submit Conferences

* **Actor**: Speaker. 
* **Description**: A speaker can submit conferences. 
* **Preconditions and Postconditions**: For a speaker to be able to add conferences, he/she has to be in the conference (preconditions). When a speaker adds a conference, it is visible in the application for all users (postconditions). 
* **Normal Flow**: 
   * The device has to be connected to the internet
   * Actor has to login/create an account
   * Actor has to select mode Speaker
   * Actor selects "Let'Start" in the app
   * Actor writes the new conference
   * Actor submits name
   * The new conference is now available to everyone to see and choose
* **Alternative Flows and Exceptions**:
   * Device is not connected to the internet 
      * Appears an error, not allowing the system to run
   * Participant tries to submit an empty conference
      * It's not possible to send empty strings, so nothing will be submitted

#### Submit Sessions

* **Actor**: Speaker. 
* **Description**: A speaker can submit sessions of a conference. 
* **Preconditions and Postconditions**: For a speaker to be able to add sessions, he/she has to be in the conference (preconditions). When a speaker adds a session, it is visible in the application for all users (postconditions). 
* **Normal Flow**: 
   * The device has to be connected to the internet
   * Actor has to login/create an account
   * Actor has to select mode Speaker
   * Actor selects "Let'Start" in the app
   *  He/she has to choose a conference
   * Actor writes the new session
   * Actor submits name
   * The new session is now available to everyone to see and choose
* **Alternative Flows and Exceptions**:
   * Device is not connected to the internet 
      * Appears an error, not allowing the system to run
   * Participant tries to submit an empty session
      * It's not possible to send empty strings, so nothing will be submitted


### User stories

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/rita/imgs/participante.PNG)

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/rita/imgs/speaker.PNG)

#### https://miro.com/welcomeonboard/0VwIWUWJCAam5D5l1AaPabkzEbWHEB1Jls5sXTl3phmohtcarxZw2JZxMV6PZtwd 

### Domain model

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/rita/imgs/uml.png)

## Architecture and Design

In this app, the first page to appear (main page) is the login page. In this page the user can enter in the application with the account he already has or he can create a new account. Regardless of already having an account or not, after the user registers his credentials he will be redirected to a page where he can choose if he wants to participate as an participant or as a speaker. Regardless of the option, the user will firstly be redirected to a page where he can choose if he wants to start to interact in the app (Let's Start) or if he wants to edit his profile. If he is an participant and he chooses the "Let's Start" option, he will see in another page (Choose conference page) all the existing conferences in the app, and he will be able to choose one of them. After he chooses one of the conferences, he will be able to choose a session in the Choose session page and after that he can ask a question or see all the questions made by other participants in the Ask questions page, or he can rate the said session in the Rate session page. However, if the user is a speaker and he chooses the Let's Start option, he will be redirected to the Choose conference page and in this case not only he will be able to see all the conferences in the app, but he also can create a new conference. Whichever the case, in this page he can choose a conference and he will be redirected to the Choose session page, where he can consult all the session of that specific conference and he also can create a new one. After he chooses an session, he can check the questions that all participants made related to that session or he can check the medium rate that that session received.
As a participant or as a speaker, after the login the users are also able to edit their profiles (Edit profile page).

### Logical Architecture

### Physical Architecture

### Prototype

## Implementation

## Test

## Configuration and change management

## Project Management

## Evolution - contributions to open-cx




