# 11.10.2023
- Manas:
    - TrashTag: Added Working Logic to Scan and Add Item to Dusbin & Show updated points!
    - ReCyclX: Added the MyJobs Section & Job Booking Logic
    - Backend: Added the Latest Routes

# 22.08.2023
- Manas:
    - Changed to Permalink Vercel Hosted Backend as fallback
    - Login & Register: Added Toast and message showing
    - backend.dart: Created the ResponseType class to wrap responses
    - BinOcculars: Addd ErrorHandling
    - LocationStuff: Added retrying capablity, until user clicks on Always it will keep asking permission. Beyond 5, it will display a text showing please enable location

# 21.08.2023
- Manas:
    - Created AuthSystem (login, register, logout) along with State persistence
    - Added Ability to Modify Server Link from within the application
- Somnath:
    - Changed Binoculars => BinOcculars
    - Made all the filter buttons into those of equal width

# 20.08.2023
- Manas:
    - Fixed Google Maps Navigation Link to include origin & travel mode
    - Included Dustbin Name in Dustbin Details
    - Added LocationSubscription to track current User location over time
    - Added New MarkerIcon for CurrentUserLocation
    - Added LoadingIndicator until Dustbins & CurrentLocation are loaded
    - Sepearated the Filtering Buttons into their own Components
    - Added MapZoom when we click on home FAB
    - Utils::initalizeLocationServices: Added awaits & made it return LocationStream
- Somnath:
    - Added More Dustbin Type Filters

# 19.08.2023
- Built App to a Certain Extent (Somnath)
- Manas: Fixed GNav
- Somnath: AppBar changes & GMap Markers & stuff
- Manas: Added LocationPermission, APIKey & General Fixes
- Somnath: Updated AppBar Icons
- Manas:
    - Connected with Backend
    - Coloured Markers
    - Distance Based Filtering
    - Go-To-UserLocation feature
    - Dustbin Type Based Filtering

# 18.08.2023 (Somnath)
- Porting of TrashTag and creation of Base App

# 17.08.2023 (Manas)
- Basic Scaffold Creation