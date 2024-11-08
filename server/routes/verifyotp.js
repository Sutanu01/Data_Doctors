const otpModel = require("../models/otp");
const userModel = require("../models/user");
const jwt = require('jsonwebtoken')

async function verifyOTP(email, inputOtp) {
    const otpRecord = await otpModel.findOne({ email, otp: inputOtp });
    if (!otpRecord) {
        throw new Error("Invalid or expired OTP");
    }

    // OTP is valid; delete it from the database
    return otpRecord;
}

async function verifyotp(req, res) {
	let {email, otp} = req.body

    try {
        const record = await verifyOTP(email, otp); // Assuming verifyOTP is a function that validates OTP

        // If not verified, error is thrown

        const user = await userModel.create({
            firstName: record.firstName,
            lastName: record.lastName,
            mobileNumber: record.mobileNumber,
            email,
            password: record.password,
        })

        // Generate JWT token
		const token = jwt.sign({ email: email, userid: user._id }, process.env.JWT_SECRET);
	
		// Set token as a cookie
		res.cookie("token", token, { httpOnly: true, secure: true }); // Use secure cookies in production
        otpModel.deleteOne({ email }); // delete from temporary db
        return res.status(201).send("Account created successfully")

    } catch (error) {
        // If OTP verification fails, respond with an error message
        return res.status(400).send("Invalid or expired OTP. Please try again.");
    }
}

module.exports = {
	verifyotp
}
