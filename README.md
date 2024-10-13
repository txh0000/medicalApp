# medicalapp

A new Flutter project for Medication.

## Getting Started

Inside the code, I do a fade, scale and colorize animation to show a welcome page(main page) for user then only go to the login page.
https://pub.dev/documentation/animated_text_kit/latest/

In the login page, I create place for user to input username and password which I set it default as 123 and 123. 

If the input is incorrect the input block will become red and ask for reinsert the password or username.

It will show "Login successful" if correctly login.

I also create a "Create Account" at the bottom of the login button. I didnt do the page for sign up this time.

There is also a "Forget password" there, I now just create if on press it, directly show the default username and password 

Inside the data_page will show the medication list data.

Click the bottom right "+" floating button will pop up a page for user to input. ID will set as current date time so it will always be specified. Then input a name and dose. The dose is only valid for double datatype. Then click on select time will show out a clock for user to just move it to the time wanted

After clicking the add, it will show a feedback that tell successfully added and close the add medication page.

Then, the added data will show on the data_page screen with name, dose and time.

On the right side of the data, there is two icon which is use for update and delete the selected data

At last, at the top right that is a log out icon button which use to log out. If press on it, the whole app will restart and all the data will now be clear as I have no put some where to save it.

I have created a class called prescription_medication but I no using here actually, just a class created for future information for medication.