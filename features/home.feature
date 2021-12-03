Feature: See a list of available requests
  As a student using LionHelp
  I want to see a list of available requests

Background: posts have been added to database

  Given the following posts exists
  | title   | location    | startTime         | endTime           | taskDetails                                 | credit  | email             | helperStatus  | helperEmail             | helperComplete  | requesterComplete |
  | Post 1  | CSC 421     | 14/09/2011 14:09  | 14/09/2011 14:09  | I need a type C charger for about an hour.  | 2.5     | abc@columbia.edu  | true          | abd@columbia.edu        | true            | true              |
  | Post 2  | CSC 421     | 14/09/2011 14:09  | 14/09/2011 14:09  | I need a type C charger for about an hour.  | 2.5     | abd@columbia.edu  | false         | null                    | false           | false             |

  And the following comments exists
  | commenter         | commentee         | content                             | postID  |
  | abc@columbia.edu  | abd@columbia.edu  | Instant Help! Really appreciate it! | 1       |

  And the following users exists
  | id | email             | firstName     | lastName          | password          |
  | 1  | abc@columbia.edu  | bc            | a                 | 123               |
  | 2  | abd@columbia.edu  | bd            | a                 | 123               |

  Then 2 seed posts should exist
  And 1 seed comments should exist
  And 2 seed users should exist

Scenario: See a list of available requests successfully
When I logged in with email = abd@columbia.edu and password = 123
Then I am on the LionHelp homepage
And I see a list of available requests successfully 