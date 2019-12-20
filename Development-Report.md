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

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/master/imgs/use_case2.png/)

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

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/master/imgs/participante.PNG)

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/master/imgs/speaker.PNG)

#### https://miro.com/welcomeonboard/0VwIWUWJCAam5D5l1AaPabkzEbWHEB1Jls5sXTl3phmohtcarxZw2JZxMV6PZtwd 

* **User stories**: "As a participant I want to register" / "As a speaker I want to register"
   * **Value**: Must have
   * **Effort**: L
   
* **User stories**: "As a registered participant/speaker, I am required to log in so that I can access the system"
   * **Value**: Must have
   * **Effort**: L

* **User stories**: "As a participant/speaker I want to edit my account so that I can update my personal information"
   * **Value**: It's not really necessary
   * **Effort**: M
   
* **User stories**: "As a participant/speaker I want to see the list of available conferences, so that I can choose one"
   * **Value**: Must have
   * **Effort**: L
 
* **User stories**: "As a speaker, I want to add my conference, if necessary, so that I can choose it later"
   * **Value**: Must have
   * **Effort**: L
   
* **User stories**: "As a participant I want to see the list of available conferences, so that I can choose one"
   * **Value**: Must have
   * **Effort**: L
   
* **User stories**: "As a speaker I want to add the session I'm presenting, if necessary, so that I can manage it later"
   * **Value**: Must have
   * **Effort**: L
   
* **User stories**: "As a speaker I want to see the list of available sessions, so that I can choose the one I'm doing"
   * **Value**: Must have
   * **Effort**: L
   
* **User stories**: "As a participant I want to ask a question for the speaker to answer"
   * **Value**: Must have
   * **Effort**: L
   
 * **User stories**: "As a participant I want to rate the session"
   * **Value**: Must have
   * **Effort**: L
   
 * **User stories**: "As a participant I want to check all the questions submitted"
   * **Value**: Must have
   * **Effort**: L
   
* **User stories**: "As a speaker I want to check all the questions submitted, so that I can answer them in the end"
   * **Value**: Must have
   * **Effort**: L
   
* **User stories**: "As a speaker I want to check the session rate given by my audience"
   * **Value**: Must have
   * **Effort**: L

### Domain model

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/master/imgs/uml.png)

## Architecture and Design

In this app, the first page to appear (main page) is the login page. In this page the user can enter in the application with the account he already has or he can create a new account. After the user is logged in, he can choose to use the app as a participant or as a speaker. Regardless of the option, the user will firstly be redirected to a page where he can choose if he wants to start to interact in the app (Let's Start) or if he wants to edit his profile. In the Edit profile page the user can edit his personal information. In the Let's start option the user will be redirected to the Conference page where he can see all the existing conferences, and if the user is a speaker he can also add a new conference. After choosing a conference the user will see all the available session in that specific conference, and, once again, if the user is a speaker he can also add a new session. Following the choice of the session, a participant can see all questions asked by other participants and he also can ask a new question, or he can rate the session. A speaker only can consult the questions asked and the medium rate that that session received.  

### Logical Architecture

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/master/imgs/logic.png)

### Physical Architecture
Our application was developed through Flutter. We choose Flutter because it was highlight recommended, is a free and open source Google mobile UI framework that allows you to create a native mobile app for IOS and Android.

We use the  Google Firebase because it's free and simple to use, allows us to add and delete data and see all of the data in real time.
We also use an authentication system (Email and Password) provided by the Firebase, which facilitates the entire login validation process.

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/master/imgs/PhysicalArchitecture.png)

### Prototype

In the initial prototype of our app we began to decide the main features it should have. As we were deciding that, we started to develop our user stories and building some mockups, while having in mind all the principle features that the app should have after being finished.

## Implementation

* **Iteration 1**: Learned Flutter and prototype development.
* **Iteration 2**: In this iteartion we implemented the login and register features, as well the edit profile features.
* **Iteration 3**: We continued the work we had been doing in iteration 2 and did the part where an user can ask a question.
* **Iteration 4**: Slightly changed the way our app was working and incorporated some features as adding conferences, adding session, rating a session and we made a distinction between to types of users, participant and speaker. While making this additions we also had to change the original design of the app, due to the fact that several new pages were created.

## Test

## Configuration and change management

During the development of our project we tried to follow the Github flow whenever it was possible, but we mainly focused in the use of branches and in the merge of those branches with the master branch.

## Project Management

#### https://github.com/softeng-feup/open-cx-high-on-caffeine/projects/1?fbclid=IwAR0FcorEah2shTmrkJo6q0kxakvcSEy2K9xtVadzPI81cqjMn242F65ckeQ

## Evolution - contributions to open-cx
Issue: Create a global perspective for the organizer on how the conference went.
https://github.com/softeng-feup/open-cx/issues/54

It would be interesting for the conference organizer to know how his conference went, especially to know the positive critiques and most importantly the negative ones to improve in the future. And also have the possibility to know which conferences were the most successful.

When the organizer logs in, he would have access to two types of information :

* the list of conferences he organized from highest to worst, and their specific rating (the rating of each one would be calculated by averaging all the sessions ratings that are part of the conference).
* the list of all the comments left by participants about each conference, divided into positives and negatives (when a participant enters a comment, they would be required to enter the type, positive or negative).



