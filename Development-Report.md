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

![alt text](https://github.com/softeng-feup/open-cx-high-on-caffeine/blob/master/imgs/use_case.png)

#### Ask Question

* **Actor**: Participant. 
* **Description**: A participant can ask questions. 
* **Preconditions and Postconditions**. For a participant to be able to ask questions, he/she has to be in the conference (preconditions). When a participant asks a question it is visible in the application for the speaker and other participants (postconditions). 
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
   * App doesn't allow create an account that already exists
   * At creating account, a password can't have less than 6 characters
   * It's not possible to send empty questions

#### Check Questions

* **Actor**: Participant. 
* **Description**: A participant can check all the questions made by all the attendees of the conference. 
* **Preconditions and Postconditions**. For a participant to be able to check questions, he/she has to be in the conference (preconditions). All questions can be checked by all conference attendees (postconditions). 
* **Normal Flow**. Provide a detailed description of the user actions and system responses that will take place during execution of the use case under normal, expected conditions. This dialog sequence will ultimately lead to accomplishing the goal stated in the use case name and description. This is best done as a numbered list of actions performed by the actor, alternating with responses provided by the system. 
* **Alternative Flows and Exceptions**. Document other, legitimate usage scenarios that can take place within this use case, stating any differences in the sequence of steps that take place. In addition, describe any anticipated error conditions that could occur during execution of the use case, and define how the system is to respond to those conditions.  

#### Attend Conference

* **Actor**: Participant. 
* **Description**: A participant can attend a certain conference and participate in it. 
* **Preconditions and Postconditions**. For a participant to be able to check questions, he/she has to be in the conference (preconditions). All questions can be checked by all conference attendees (postconditions). 
* **Normal Flow**. Provide a detailed description of the user actions and system responses that will take place during execution of the use case under normal, expected conditions. This dialog sequence will ultimately lead to accomplishing the goal stated in the use case name and description. This is best done as a numbered list of actions performed by the actor, alternating with responses provided by the system. 
* **Alternative Flows and Exceptions**. Document other, legitimate usage scenarios that can take place within this use case, stating any differences in the sequence of steps that take place. In addition, describe any anticipated error conditions that could occur during execution of the use case, and define how the system is to respond to those conditions.  

### User stories
This section will contain the requirements of the product described as **user stories**, organized in a global **user story map** with **user roles** or **themes**.

For each theme, or role, you may add a small description here. User stories should be detailed in the tool you decided to use for project management (e.g. trello or github projects).

A user story is a description of desired functionality told from the perspective of the user or customer. A starting template for the description of a user story is 

*As a < user role >, I want < goal > so that < reason >.*

You add more details after, but the shorter and complete, the better. In order to decide if the user story is good, please follow the INVEST guidelines.

After the user story text, you should add a draft of the corresponding user interfaces, a simple mockups or drafts, if applicable.

For each user story you should write also the acceptance tests (textually in Gherkin), ie, a description of situations that will help to confirm that the system satisfies the requirements addressed in the user story.

At the end, it is good to add a rough indication of the value of the user story to the customers (e.g. MoSCoW method) and the team should add an estimative of the effort to implemente it, in t-shirt sizes (XS, S, M, L, XL).

### Domain model

A simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module.


