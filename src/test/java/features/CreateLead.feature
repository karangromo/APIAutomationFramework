Feature: Create Lead

  # Create JDBC connection with DbUtils java class
* def config = { username: ‘root’, password: ‘root’, url: ‘jdbc:mysql://localhost:3306/sample_db’, driverClassName: ‘com.mysql.jdbc.Driver’ }
* def DbUtils = Java.type(‘util.DbUtils’)
* def db = new DbUtils(config)

 # Create local variables for this feature file
* def dataFaker = Java.type("utils.commonUtils")
* def mobileNumber = '6'+dataFaker.getRandomInteger(9)
* path '/api/v1/cms'
* url baseUrl
* def sleep = function(pause){ java.lang.Thread.sleep(pause*500) }



  @Test2
  Scenario: Create customer with invalid mobile number
    * def requestBody = {"gpLinked":[{"gpId":"4WI56260","isBonusCustomer":false,"isVerifiedByGP":false,"campaignInfo":{"source":"Add Customer","medium":"GP App","tags":"Added by GP"},"customerDetails":{"firstName":"Karan","lastName":"Singh","kycDetails":{"pan":"CHQPG0979N"},"gender":"Male","emailId":"karan@maildrop.cc","permanentAddress":{"pincode":122002}}}],"isCustomerGP":false,"isGromoExclusive":false,"primaryPhoneNumber": "4234567891"}
    And request requestBody
    When method POST
    * call sleep(3)
    Then status 400
    And print response
    And match response.message[*] !contains '["Primary phone number must be 10 digits and start with 6, 7, 8, or 9"]'

    # Verify from database
   * def vehicles = db.readRows(‘SELECT * FROM vehicles’)Then match vehicles contains {vehicle_id:1, availability:’true’, type:#ignore }
   * def vehicle = db.readRow(‘SELECT * FROM vehicles D WHERE D.vehicle_id = 2;’)
   Then match vehicle.availability == ‘false’
   * def test = db.readValue(‘SELECT ID FROM vehicles D WHERE D.ID = ‘ + 3;’)
   * match test == id