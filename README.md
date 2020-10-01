# augmented_reaility

A flutter application made based on AR implementation using QR code.

## Getting Started

The app uses the camera of the phone to scan a QR code placed in the desired position where you want to render the object. The QR code contains a link to a 3D object hosted on a file sharing website which then downloads the model rendered onto our device and is ready to be placed, as well as an anchor containing the details of the object i.e. where the user wants to place it, other details of the model etc. The user then has to detect a suitable surface(well lit, plane surface) and then places an anchor which is then shared with the model, as it contains the place where we want to render the object. The anchor is necessary in order to place the object, as when the object goes out of scope of the camera, we still need it to stick where we have initially rendered it, as we do not want to render it again and again. Currently, only one object is supported at a time, but we hope to expand the capability in the future, and also will include the concept of multi user AR, a feature currently unsupported by hybrid apps

## ScreenShots

<p>
    <img src="https://github.com/anirudhsharma392/3D-Blueprints/blob/master/screenshots/unnamed.png"/>
    <img src="https://github.com/anirudhsharma392/3D-Blueprints/blob/master/screenshots/unnamed-2.png"/>
    <img src="https://github.com/anirudhsharma392/3D-Blueprints/blob/master/screenshots/chair.png"/>

</p>


# 👍 Contribution
1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -m 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

For help getting started with Flutter,
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
