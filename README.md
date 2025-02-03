
To generate translation files, in terminal run: `flutter gen-l10n --arb-dir assets/l10n`

To generate api client (retrofit), in terminal run: `flutter pub run build_runner build`

To generate json serializers, in terminal run:`dart run build_runner build`



AADBDT PROJECT ASSIGNMENT
Create an app to upload and browse photos.
Functional requirements:
• The application supports work with a registered, anonymous, and administrator type of user –
10 points for LO1 Minimum
• User registration must be enabled using a local account (5 points for LO1 Minimum), Google,
and Github (5 points for LO1 Desired) – LO1
o When registering a user, you have to choose one of the packages for use: FREE, PRO, or
GOLD - limit the price of the package yourself (e.g., upload size, daily upload limit,
maximum spend of uploaded photos, etc.)
o Users can track the current consumption in their current package
o Users can change the packet once a day (change is valid from the following day)
• Users can set one or more hashtags and a description of a photo when uploading – 8 points for
LO4 Minimum
o The user can choose how the image will be processed before being saved (e.g., resize,
PNG/JPG/BMP format)
• Use can browse all uploaded photos – LO2
o Registered users can modify the description and hashtags of their photos while the
anonymous user can only browse uploaded photos (8 points for LO2 Minimum)
o By default, thumbnails of 10 last uploaded photos are displayed with a description,
author, upload DateTime, and hashtags (4 points for LO2 Desired)
o Click on the photo thumbnail displays the whole photo (1 point for LO2 Desired)
• User can search photos based on given filter – 10 points for LO3 Minimum
o Hashtags, size, upload DateTime range, author
• User can download the photo – LO4
o When downloading, the user can choose to download the original photo (7 points for
LO4 Minimum) or the photo with applied selected filters - e.g., resize + sepia + blur +
format (5 points for LO4 Desired)
• Administrator can do everything that registered user can, and additionally – 7 points for LO2
Minimum
o Modify the profile and packages of the user
o View user actions and user statistics
o Manage images of any user
Nonfunctional requirements:
• Logging of every action has to be implemented: by who, when, and what operation was made –
5 points for LO3 Minimum
• Depending on the chosen configuration, photos have to be saved on local storage or Amazon s3
bucket – 5 points for LO3 Desired
• App has to be implemented as a web, desktop, or mobile application using an object-oriented
language – 15 points for Minimum and 5 points for Desired LO5

