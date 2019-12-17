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

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/master/imgs/use_case.png/)

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/master/imgs/use_case2.png/)

#### Edit Account

* **Actor**: Participant.
* **Description**: A participant can check their own account details, and edit them.
* **Preconditions and Postconditions**: In order for a participant to access/edit their account data, they only need to be logged in (preconditions), any changes will be saved and updated for the next time he checks his account (postconditions).
* **Normal Flow**: 
   * The device has to be connected to the internet
   * Actor has to login/create an account
   * Actor selects "Edit Account" in the app
   * Name, Country and College info are shown on the screen
   * The actor can change any information or delete it
   * He can submit the changes, and regardless of the changes he made, they are saved
* **Alternative Flows and Exceptions**:
   * Device is not connected to the internet 
      * Appears an error, not allowing the system to run
   * Participant change the information but does not send it
      * Nothing is stored, so the information are the same as the last change submitted

#### Check Questions

* **Actor**: Participant. 
* **Description**: A participant can check all the questions made by all the attendees of the conference. 
* **Preconditions and Postconditions**: For a participant to be able to check questions, he/she has to be in the conference (preconditions). All questions can be checked by all conference attendees (postconditions). 
* **Normal Flow**:
   * The device has to be connected to the internet
   * Actor has to login/create an account
   * Actor selects "Ask Questions" in the app
   * All questions are shown on the screen, as well the email of the user that submited it
* **Alternative Flows and Exceptions**:
  * Device is not connected to the internet 
      * Appears an error, not allowing the system to run

#### Ask Question

* **Actor**: Participant. 
* **Description**: A participant can ask questions. 
* **Preconditions and Postconditions**: For a participant to be able to ask questions, he/she has to be in the conference (preconditions). When a participant asks a question it is visible in the application for the speaker and other participants (postconditions). 
* **Normal Flow**: 
   * The device has to be connected to the internet
   * Actor has to login/create an account
   * Actor selects "Ask Questions" in the app
   * Actor writes the question he wants to ask
   * Actor submits question
   * Question is available to everyone to see, as well the email of the user that submited it
* **Alternative Flows and Exceptions**:
   * Device is not connected to the internet 
      * Appears an error, not allowing the system to run
   * Participant tries to submit an empty question
      * It's not possible to send empty questions, so nothing will be submitted

The rest of the tasks have not yet been implemented.

### User stories

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/master/imgs/participante.PNG)

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/master/imgs/speaker.PNG)

#### https://miro.com/welcomeonboard/0VwIWUWJCAam5D5l1AaPabkzEbWHEB1Jls5sXTl3phmohtcarxZw2JZxMV6PZtwd 

### Domain model




