Feature: Create Customer

  Background:
    * def dataFaker = Java.type("utils.commonUtils")
    * def mobileNumber = '6'+dataFaker.getRandomInteger(9)
    * path '/api/v1/cms'
    * url baseUrl
    * def sleep = function(pause){ java.lang.Thread.sleep(pause*1000) }
    * def requestBody = read('/Users/user02/IdeaProjects/APIAutomationFramework/src/test/java/requestPayload/CreateCustomer.json')

    #Create db connection
    * def config = { username: 'sa', password: '', url: 'jdbc:h2:mem:testdb', driverClassName: 'org.h2.Driver' }
    * def DbUtils = Java.type("utils.DbUtils")
    * def db = new DbUtils(config)


  @Tag1
  Scenario: Create customer with valid mobile number
    * def requestBody = {"gpLinked":[{"gpId":"4WI56260","isBonusCustomer":false,"isVerifiedByGP":false,"campaignInfo":{"source":"Add Customer","medium":"GP App","tags":"Added by GP"},"customerDetails":{"firstName":"Karan","lastName":"Singh","kycDetails":{"pan":"CHQPG0979N"},"gender":"Male","emailId":"karan@maildrop.cc","permanentAddress":{"pincode":122002}}}],"isCustomerGP":false,"isGromoExclusive":false,"primaryPhoneNumber": "#(mobileNumber)"}
    Given url 'https://stg-csf-api.gromo.in/api/v1/cms'
    And request requestBody
    When method POST
    Then status 201
    And print response
    And match response.message == 'Customer created successfully'
#    And match response.data[0].first_name != null

  @Tag2
  Scenario: Create customer with invalid mobile number
    * set requestBody.gpLinked[0].gpId = '4WI56269'
    And request requestBody
    When method POST
    * call sleep(3)
    Then status 400
    And print response
    And match response.message[*] !contains '["Primary phone number must be 10 digits and start with 6, 7, 8, or 9"]'

#    Examples:
#    | index |
#    | 0     |

  @Tag3
  Scenario: Validate values from mysql database
    * def dbValue = db.readValues('select salary from employee where id=200')