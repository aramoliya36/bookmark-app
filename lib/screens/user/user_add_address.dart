import 'dart:async';

import 'package:bookmrk/api/location_name_api.dart';
import 'package:bookmrk/api/map_api.dart';
import 'package:bookmrk/api/user_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/get_state_city_pin_model.dart';
import 'package:bookmrk/provider/city_model.dart';
import 'package:bookmrk/provider/country_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/location_name_provider.dart';
import 'package:bookmrk/provider/map_provider.dart';
import 'package:bookmrk/provider/state_model.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/widgets/addressTextfields.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:search_place_autocomplete/search_place_autocomplete.dart';

class UserAddAddress extends StatefulWidget {
  @override
  _UserAddAddressState createState() => _UserAddAddressState();
}

class _UserAddAddressState extends State<UserAddAddress> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// TextFields
  TextEditingController _firstNameAddressController = TextEditingController();
  TextEditingController _lastNameAddressController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _contactNumberAddressController =
      TextEditingController();
  TextEditingController _zipCodeAddressController = TextEditingController();
  TextEditingController _countryCodeAddressController = TextEditingController();
  TextEditingController _stateNameAddressController = TextEditingController();
  TextEditingController _cityNameAddressController = TextEditingController();
  TextEditingController _firstAddressController = TextEditingController();
  TextEditingController _secondAddressController = TextEditingController();

  /// get all country
  Future getAllCountry() async {
    dynamic response = await LocationNameAPI.getAllCountryName();
    CountryModel _countryModel = CountryModel.fromJson(response);
    _countryModel.response.forEach((country) {
      if (country.name.toLowerCase() == "india") {
        Provider.of<LocationProvider>(context, listen: false)
            .selectedCountryName = country.name;
        Provider.of<LocationProvider>(context, listen: false)
            .selectedCountryId = int.parse(country.countryId);
      }
    });
    Provider.of<LocationProvider>(context, listen: false).selectedCountryName;
    return _countryModel;
  }

  /// get all state of selected country
  Future getAllStateOfSelectedCountry(int countryId) async {
    dynamic response = await LocationNameAPI.getAllStateOfCountry(countryId);
    StateModel _stateModel = StateModel.fromJson(response);
    return _stateModel;
  }

  /// get all city of selected state
  Future getAllCityOfSelectedState(int stateId) async {


    dynamic response = await LocationNameAPI.getAllCityOfState(stateId);
    CityModel _cityModel = CityModel.fromJson(response);
    return _cityModel;
  }

  /// get the current location of the user....
  getLocation() async {
    Location _location = Location();

    if (await _location.hasPermission() == PermissionStatus.granted) {
      LocationData value = await _location.getLocation();
      Provider.of<MapProvider>(context, listen: false).addressSelectedLatLng =
          LatLng(value.latitude, value.longitude);
    } else {
      _location.requestPermission().then((value) async {
        if (value == PermissionStatus.granted) {
          LocationData value = await _location.getLocation();
          Provider.of<MapProvider>(context, listen: false)
              .addressSelectedLatLng = LatLng(value.latitude, value.longitude);
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) => _scaffoldKey
              .currentState
              .showSnackBar(getSnackBar('Please Give Permission !')));
        }
      });
    }
  }

  void resetControllers() {
    Provider.of<LocationProvider>(context, listen: false)
        .selectedCountryNameInit = "";
    Provider.of<LocationProvider>(context, listen: false)
        .selectedCountryIdInit = null;
    Provider.of<LocationProvider>(context, listen: false)
        .selectedStateNameInit = "";
    Provider.of<LocationProvider>(context, listen: false).selectedStateIdInit =
        null;
    Provider.of<LocationProvider>(context, listen: false).selectedCityNameInit =
        "";
    Provider.of<LocationProvider>(context, listen: false).selectedCityIdInit =
        null;
    _zipCodeAddressController.text = "";

    _firstAddressController.text = "";

    Provider.of<LocationProvider>(context, listen: false)
        .isLocationSelectedFromMapInit = false;
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    getLocation();
    resetControllers();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Consumer<LocationProvider>(
        builder: (_, _locationProvider, child) => Consumer<UserProvider>(
          builder: (_, _userProvider, child) => Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: width / 20,
                      ),
                      AddressTextFields(
                          width: width,
                          title: "First Name",
                          controller: _firstNameAddressController),
                      SizedBox(
                        height: width / 20,
                      ),
                      AddressTextFields(
                          width: width,
                          title: "Last Name",
                          controller: _lastNameAddressController),
                      SizedBox(
                        height: width / 20,
                      ),
                      AddressTextFields(
                          width: width,
                          title: "Email",
                          controller: _emailAddressController),
                      SizedBox(
                        height: width / 20,
                      ),
                      AddressTextFields(
                          width: width,
                          title: "Contact Number",
                          controller: _contactNumberAddressController),
                      SizedBox(
                        height: width / 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _locationProvider.isLocationSelectedFromMap
                                ? () {
                                    Provider.of<LocationProvider>(context,
                                            listen: false)
                                        .selectedCountryName = "";
                                    Provider.of<LocationProvider>(context,
                                            listen: false)
                                        .selectedCountryId = null;
                                    Provider.of<LocationProvider>(context,
                                            listen: false)
                                        .selectedStateName = "";
                                    Provider.of<LocationProvider>(context,
                                            listen: false)
                                        .selectedStateId = null;
                                    Provider.of<LocationProvider>(context,
                                            listen: false)
                                        .selectedCityName = "";
                                    Provider.of<LocationProvider>(context,
                                            listen: false)
                                        .selectedCityId = null;
                                    _zipCodeAddressController.text = "";
                                    _firstAddressController.text = "";
                                    _locationProvider
                                        .isLocationSelectedFromMap = false;
                                  }
                                : () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 40.0,
                                                vertical: 150.0),
                                            color: colorPalette.navyBlue,
                                            child: Material(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    color:
                                                        colorPalette.navyBlue,
                                                    child: Row(
                                                      children: [
                                                        Spacer(),
                                                        Consumer<MapProvider>(
                                                          builder: (_,
                                                              _mapProvider,
                                                              child) {
                                                            return GestureDetector(
                                                              onTap: () async {
                                                                dynamic response = await MapAPI.getAddressFromLatLng(
                                                                    _mapProvider
                                                                        .addressSelectedLatLng
                                                                        .latitude,
                                                                    _mapProvider
                                                                        .addressSelectedLatLng
                                                                        .longitude);

                                                                if (response[
                                                                        'status'] ==
                                                                    "OK") {
                                                                  _mapProvider
                                                                      .addressLine1FromLatLng = response[
                                                                          'results'][0]
                                                                      [
                                                                      'formatted_address'];
                                                                  _mapProvider
                                                                          .isLatLngSelected =
                                                                      true;
                                                                  _firstAddressController
                                                                          .text =
                                                                      _mapProvider
                                                                          .addressLine1FromLatLng;
                                                                  dynamic locationDataResponse = await LocationNameAPI.getStateCityPin(
                                                                      _mapProvider
                                                                          .addressSelectedLatLng
                                                                          .latitude
                                                                          .toString(),
                                                                      _mapProvider
                                                                          .addressSelectedLatLng
                                                                          .longitude
                                                                          .toString());



                                                                  GetStateCityPinModel
                                                                      _getStateCityPinModel =
                                                                      GetStateCityPinModel
                                                                          .fromJson(
                                                                              locationDataResponse);
                                                                  Provider.of<LocationProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .selectedCountryName = "${_getStateCityPinModel.response[0].country}";
                                                                  Provider.of<LocationProvider>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .selectedCountryId =
                                                                      int.parse(
                                                                          "${_getStateCityPinModel.response[0].countryId == "" || _getStateCityPinModel.response[0].countryId == null ? "0" : _getStateCityPinModel.response[0].countryId}");
                                                                  Provider.of<LocationProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .selectedStateName = "${_getStateCityPinModel.response[0].state}";
                                                                  Provider.of<LocationProvider>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .selectedStateId =
                                                                      int.parse(
                                                                          "${_getStateCityPinModel.response[0].stateId == "" || _getStateCityPinModel.response[0].stateId == null ? "0" : _getStateCityPinModel.response[0].stateId}");
                                                                  Provider.of<LocationProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .selectedCityName = "${_getStateCityPinModel.response[0].city}";
                                                                  Provider.of<LocationProvider>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .selectedCityId =
                                                                      int.parse(
                                                                          "${_getStateCityPinModel.response[0].cityId == "" || _getStateCityPinModel.response[0].cityId == null ? "0" : _getStateCityPinModel.response[0].cityId}");
                                                                  _zipCodeAddressController
                                                                          .text =
                                                                      "${_getStateCityPinModel.response[0].pincode}";

                                                                  _locationProvider
                                                                          .isLocationSelectedFromMap =
                                                                      true;
                                                                  Navigator.pop(
                                                                      context);
                                                                } else {
                                                                  _mapProvider
                                                                      .addressLine1FromLatLng = "";
                                                                  _firstAddressController
                                                                          .text =
                                                                      _mapProvider
                                                                          .addressLine1FromLatLng;
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                              child: Text(
                                                                'Done',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18.0),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 20.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child:
                                                          Consumer<MapProvider>(
                                                        builder: (_,
                                                                _mapProvider,
                                                                child) =>
                                                            Stack(
                                                          children: [
                                                            GoogleMap(
                                                              initialCameraPosition:
                                                                  CameraPosition(
                                                                target: LatLng(
                                                                    _mapProvider
                                                                        .addressSelectedLatLng
                                                                        .latitude,
                                                                    _mapProvider
                                                                        .addressSelectedLatLng
                                                                        .longitude),
                                                                zoom: 14,
                                                              ),
                                                              onTap:
                                                                  (position) async {
                                                                _mapProvider
                                                                        .addressSelectedLatLng =
                                                                    position;
                                                              },
                                                              onMapCreated:
                                                                  (GoogleMapController
                                                                      controller) {
                                                                _controller
                                                                    .complete(
                                                                        controller);
                                                              },
                                                              minMaxZoomPreference:
                                                                  MinMaxZoomPreference(
                                                                      9, 20),
                                                              markers: {
                                                                Marker(
                                                                    markerId:
                                                                        MarkerId(
                                                                            "1"),
                                                                    visible:
                                                                        true,
                                                                    position:
                                                                        LatLng(
                                                                      _mapProvider
                                                                          .addressSelectedLatLng
                                                                          .latitude,
                                                                      _mapProvider
                                                                          .addressSelectedLatLng
                                                                          .longitude,
                                                                    ))
                                                              },
                                                            ),
                                                            Container(
                                                              child: Material(
                                                                child:
                                                                    SearchPlaceAutoCompleteWidget(
                                                                  // YOUR GOOGLE MAPS API KEY
                                                                  apiKey:
                                                                      kMapKey,
                                                                  // Language that you want. Default is English='en'
                                                                  language:
                                                                      'en',
                                                                  // Country that you want to filter for. Default is Ethopia='ET'
                                                                  components:
                                                                      "IN",

                                                                  placeholder:
                                                                      "Your current location",

                                                                  onSelected: (Place
                                                                      place) async {


                                                                    place
                                                                        .geolocation
                                                                        .then(
                                                                            (value) async {
                                                                      _mapProvider
                                                                              .addressSelectedLatLng =
                                                                          value
                                                                              .coordinates;

                                                                      // dynamic locationDataResponse = await LocationNameAPI.getStateCityPin(value.coordinates.latitude.toString(), value.coordinates.longitude.toString());
                                                                      // print(locationDataResponse);
                                                                      //
                                                                      // GetStateCityPinModel _getStateCityPinModel = GetStateCityPinModel.fromJson(locationDataResponse);
                                                                      // Provider.of<LocationProvider>(context, listen: false).selectedCountryName = "${_getStateCityPinModel.response[0].country}";
                                                                      // Provider.of<LocationProvider>(context, listen: false).selectedCountryId = int.parse("${_getStateCityPinModel.response[0].countryId}");
                                                                      // Provider.of<LocationProvider>(context, listen: false).selectedStateName = "${_getStateCityPinModel.response[0].state}";
                                                                      // Provider.of<LocationProvider>(context, listen: false).selectedStateId = int.parse("${_getStateCityPinModel.response[0].stateId}");
                                                                      // Provider.of<LocationProvider>(context, listen: false).selectedCityName = "${_getStateCityPinModel.response[0].city}";
                                                                      // Provider.of<LocationProvider>(context, listen: false).selectedCityId = int.parse("${_getStateCityPinModel.response[0].cityId}");
                                                                      // _zipCodeAddressController.text = "${_getStateCityPinModel.response[0].pincode}";
                                                                      //
                                                                      // _locationProvider.isLocationSelectedFromMap = true;
                                                                      final GoogleMapController
                                                                          controller =
                                                                          await _controller
                                                                              .future;
                                                                      controller
                                                                          .animateCamera(
                                                                        CameraUpdate
                                                                            .newCameraPosition(
                                                                          CameraPosition(
                                                                            target:
                                                                                LatLng(_mapProvider.addressSelectedLatLng.latitude, _mapProvider.addressSelectedLatLng.longitude),
                                                                            zoom:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                            child: Container(
                              height: 60,
                              width: width / 1.1,
                              margin: EdgeInsets.only(top: 23.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 1.2, color: Color(0x80515c6f))),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _locationProvider.isLocationSelectedFromMap
                                        ? Icons.autorenew_outlined
                                        : Icons.map,
                                    size: 30.0,
                                    color: colorPalette.navyBlue,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    _locationProvider.isLocationSelectedFromMap
                                        ? 'Reset your Location.'
                                        : 'Search Your Location',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: colorPalette.navyBlue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: width / 20,
                      ),
                      _locationProvider.isLocationSelectedFromMap
                          ? AddressTextFields(
                              width: width,
                              title: "Full Address / House Number",
                              controller: _secondAddressController)
                          : SizedBox(),
                      SizedBox(
                        height: width / 20,
                      ),
                      _locationProvider.isLocationSelectedFromMap
                          ? AddressTextFields(
                              readOnly: true,
                              width: width,
                              title: "Address / city / state",
                              controller: _firstAddressController)
                          : SizedBox(),
                      SizedBox(
                        height: width / 20,
                      ),
                      _locationProvider.isLocationSelectedFromMap
                          ? AddressTextFields(
                              width: width,
                              title: "Zip Code",
                              controller: _zipCodeAddressController)
                          : SizedBox(),
                      SizedBox(
                        height: width / 20,
                      ),
                      _locationProvider.isLocationSelectedFromMap
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: width / 2.25,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'State',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 13,
                                          color: const Color(0x80515c6f),
                                          letterSpacing: 0.9100000000000001,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: width,
                                        padding: EdgeInsets.only(
                                            top: 16.0,
                                            bottom: 17.0,
                                            left: 5.0,
                                            right: 5.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: Row(
                                          children: [
                                            Text(
                                              '${_locationProvider.selectedStateName}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width / 2.25,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'City',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 13,
                                          color: const Color(0x80515c6f),
                                          letterSpacing: 0.9100000000000001,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: width,
                                        padding: EdgeInsets.only(
                                            top: 16.0,
                                            bottom: 17.0,
                                            left: 5.0,
                                            right: 5.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: Row(
                                          children: [
                                            Text(
                                              '${_locationProvider.selectedCityName}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : SizedBox(),
                      SizedBox(
                        width: 10.0,
                      ),
                      SizedBox(
                        height: width / 1.5,
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<MapProvider>(
                builder: (_, _mapProvider, child) => Positioned(
                  bottom: 0.0,
                  child: GestureDetector(
                    onTap: () async {
                      _userProvider.isAddAddressInProcess = true;
                      int userId = prefs.read<int>('userId');



                      if (_secondAddressController.text == "" ||
                          _secondAddressController.text == null) {
                        _userProvider.isAddAddressInProcess = false;
                        Scaffold.of(context).showSnackBar(getSnackBar(
                            'Please fill House number and full address!'));
                      } else {
                        dynamic response = await UserAPI.addNewUserAddress(
                          userId.toString(),
                          _firstNameAddressController.text,
                          _lastNameAddressController.text,
                          _emailAddressController.text,
                          _contactNumberAddressController.text,
                          '${_locationProvider.selectedStateId ?? 0}',
                          '${_locationProvider.selectedCityId ?? 0}',
                          _firstAddressController.text,
                          _secondAddressController.text,
                          _zipCodeAddressController.text,
                          '${_locationProvider.selectedCountryId ?? 0}',
                          _mapProvider.addressSelectedLatLng.latitude
                              .toString(),
                          _mapProvider.addressSelectedLatLng.longitude
                              .toString(),
                        );



                        if (response['status'] == 200) {
                          _userProvider.isAddAddressInProcess = false;

                          if (Provider.of<HomeScreenProvider>(context,
                                  listen: false)
                              .selectAddressFirstTime) {
                            int userId = prefs.read<int>('userId');
                            dynamic response2 =
                                await UserAPI.changeSelectedUserAddress(
                                    userId.toString(),
                                    response['response'][0]['user_address_id']
                                        .toString());


                            if (response2['status'] == 200) {
                              Provider.of<HomeScreenProvider>(context,
                                      listen: false)
                                  .pageController
                                  .jumpToPage(4);

                              Provider.of<HomeScreenProvider>(context,
                                      listen: false)
                                  .selectedString = "Cart";
                              Provider.of<HomeScreenProvider>(context,
                                      listen: false)
                                  .selectedBottomIndex = 4;
                              Provider.of<HomeScreenProvider>(context,
                                      listen: false)
                                  .blueCartIcon = true;
                              Provider.of<HomeScreenProvider>(context,
                                      listen: false)
                                  .blueBellIcon = false;
                            } else {
                              Scaffold.of(context).showSnackBar(getSnackBar(
                                  'unable to set address as default!'));
                            }
                          } else {
                            Scaffold.of(context)
                                .showSnackBar(getSnackBar('Address is added.'));
                          }
                        } else {
                          _userProvider.isAddAddressInProcess = false;
                          Scaffold.of(context).showSnackBar(
                              getSnackBar('${response['message']}'));
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      child: Text(
                        "ADD",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      height: width / 5,
                      color: colorPalette.navyBlue,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _userProvider.isAddAddressInProcess,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
