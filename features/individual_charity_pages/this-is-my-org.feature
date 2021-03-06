Feature: This is my organization
  As a organization administrator
  So that I could be set as an admin of our organization
  I want to be able to request for the privilege through our organization page

  Background:
     Given the following users are registered:
       | email              | password       | admin | confirmed_at        | organization |
       | nonadmin@myorg.com | mypassword1234 | false | 2008-01-01 00:00:00 |              |
     And the following organizations exist:
       | name             | address        |
       | The Organization | 83 pinner road |
    And cookies are approved

  Scenario: I am a signed in user who requests to be admin for my organization
    Given I am signed in as a non-admin 
    When I am on the charity page for "The Organization"
    Then I should see a link or button "This is my organization"
    And I click "This is my organization"
    Then I should be on the charity page for "The Organization"
    And "nonadmin@myorg.com"'s request status for "The Organization" should be updated appropriately

  Scenario: I am not signed in and won't be offered "This is my organization" claim button
    When I am on the charity page for "The Organization"
    And I should not see "This is my organization"
