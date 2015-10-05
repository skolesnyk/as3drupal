# Description #
Easy to use lib to connect as3 apps with drupal


---


This project was supported and financed by the [Ghostthinker GmbH](http://www.ghostthinker.de), a German start-up company specialized on developing didactical concepts and their technical implementations.


# Updates #
## 2013/06/14 ##
We started adapting the package for the new services 3.x (d6/d7)
## 2010/05/01 ##
Working version released.
## 2009/07/22 ##
Release will be ~ first half of august



# Introduction #

as3drupal is an as3 lib to connect drupal with flash via xmlrpc. It has an easy to extend interface to quickly add new services. Drupal nodes are implemented as classes an can easiliy be extended for custom content types with  cck fields.


# Features #
  * services.module like structure (servers, services)
  * API key implementation
  * XMLRPC Server implemented
  * Node classes for drupal nodes -> easy data handling

# Services #
  * System Service
    * connect
    * disconnect
  * Node Service
    * load
    * save
    * delete
  * Views Service
    * load
  * User Service
    * login
    * loggout
  * Taxonomy Service
    * getTree
