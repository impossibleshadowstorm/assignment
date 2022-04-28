# dev_assignment

Here is a 1 Page UI that we want you to build in Flutter(Dart). There will be 2 API used one for displaying the service list and the second is on click on the "Submit" button "submit_details" Api will call. On submit button click, call API, and according to API response "status" shows the response message in the toast.

XD design link.
https://xd.adobe.com/view/134c0f66-6e46-4b82-906e-4e069faa3430-461f/
Please follow these steps
1. Open the given link and on the top right corner click on the development button(like this "</>").
2. After this when you click on any element you can get height, width, text size, color on the right side and click on the image you can download the image in SVG or png format
Notes:
1. Create a design with BottomNavigationBar and it should be responsive.
2. Above service list design(Gradient and highest rated) will be static.
3. image will pass as MultipartFile in submit_details API.
4. In the "gender" drop down there will be a male and female option.
5. Email should be in a proper format.
6. validate password and confirm password should be the same.
7. calendar will open on click on "Date of Birth" then select date and display.
8. radio button will be showing as user status. The default will be "active".
9. for service list API show English data only
10. Share the project zip file via email or google drive link.

API list
Base url : https://anaajapp.com/api/
1. Service List api :
Method- GET
Endpoint- categories
Final url- https://anaajapp.com/api/categories
2. Submit details form:
Method- POST
Endpoint- user/submit_details
Params- image:xyz.png
name:XYZ
email:xyz@gmail.com
password:123456
gender:female
dob:23/09/1990
user_status:active
