# datadoctor


HOST: https://localhost:8000/

## Registration [/register]

### Request User Registration [POST]

+ Request (application/json)

        {
            "firstName": <First Name : String>,
            "lastName": <Last Name : String>,
            "mobileNumber": <Mobile Number : String>,
            "email": <Email : String>,
            "password": <Password : String>
        }

+ Response 201 (application/json)
  
        {
            "status": "success",
            "message": "OTP has been sent to email, proceed with otp verification."
        }

+ Response 400 (application/json)
  
        {
            "status": "failure",
            "message": "Password must be at least 8 characters long, with at least one uppercase letter, one lowercase letter, one number, and one special character."
        }

+ Response 409 (application/json)
  
        {
            "status": "failure",
            "message": "Email already registered"
        }

+ Response 409 (application/json)
  
        {
            "status": "failure",
            "message": "Mobile Number Already in use"
        }

+ Response 500 (application/json)
  
        {
            "status": "failure",
            "message": "Unknown Server Error"
        }


## OTP Verification [/verifyotp]

### Request OTP Verification [POST]

+ Request (application/json)

        {
            "email": <Email : String>,
            "otp": <OTP : String>
        }

+ Response 201 (application/json)

        {
            "status": "success",
            "message": "Account created successfully"
            "token": <JWT Token : String>
        }

+ Response 400 (application/json)

        {
            "status": "failure",
            "message": "Invalid or expired OTP. Please try again."
        }

## OTP Verification [/login]

### Request Login (JWT Token) [POST]

+ Request (application/json)

        {
            "email": <Email : String>,
            "password": <Password : String>
        }

+ Response 200 (application/json)

        {
            "status": "success",
            "message": "Logged in successfully",
            "token": <JWT Token : String>
        }

+ Response 400 (application/json)

        {
            "status": "failure",
            "message": "Invalid credentials"
        }