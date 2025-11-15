import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:round_7_mobile_cure_team3/feature/map/helpers/location_helper.dart';
import 'package:round_7_mobile_cure_team3/feature/map/presentation/widgets/confirm_location_button.dart';
import 'package:round_7_mobile_cure_team3/feature/map/presentation/widgets/current_location_button.dart';
import 'package:round_7_mobile_cure_team3/feature/map/presentation/widgets/loading_indicator.dart';
import 'package:round_7_mobile_cure_team3/feature/map/presentation/widgets/map_search_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/map/presentation/widgets/map_widget.dart';
import 'package:round_7_mobile_cure_team3/feature/map/presentation/widgets/search_results_list.dart';
import 'package:round_7_mobile_cure_team3/feature/map/services/location_search_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? position;
  LatLng? selectedLatLng;

  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<LocationSearchResult> _searchResults = [];
  bool _isLoadingSearch = false;
  String? _lastSearchQuery;
  String _currentAddress = 'Loading address...';
  bool _isLoadingAddress = false;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;

    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _lastSearchQuery = null;
      });
      return;
    }

    if (query != _lastSearchQuery) {
      _lastSearchQuery = query;
      _performSearch(query);
    }
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    await Future.delayed(const Duration(milliseconds: 500));

    if (query != _searchController.text) {
      return;
    }

    setState(() {
      _isLoadingSearch = true;
    });

    final results = await LocationSearchService.searchLocation(query);

    if (mounted && query == _searchController.text) {
      setState(() {
        _searchResults = results;
        _isLoadingSearch = false;
      });
    }
  }

  void _selectLocation(LocationSearchResult result) {
    setState(() {
      selectedLatLng = result.coordinates;
      _isSearching = false;
      _searchController.clear();
      _searchResults = [];
    });

    position = Position(
      latitude: result.coordinates.latitude,
      longitude: result.coordinates.longitude,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );

    _mapController.move(result.coordinates, 17);
    _updateAddress(result.coordinates);
  }

  Future<void> _updateAddress(LatLng coordinates) async {
    setState(() {
      _isLoadingAddress = true;
    });

    final address = await LocationSearchService.getAddressFromCoordinates(
      coordinates,
    );

    if (mounted) {
      setState(() {
        _currentAddress = address;
        _isLoadingAddress = false;
      });
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      final pos = await LocationHelper.getCurrentLocation();
      final latLng = LatLng(pos.latitude, pos.longitude);

      setState(() {
        position = pos;
        selectedLatLng = latLng;
      });

      Future.delayed(const Duration(milliseconds: 200), () {
        _mapController.move(latLng, 15);
      });
      _updateAddress(latLng);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _onMapTap(LatLng point) {
    setState(() {
      selectedLatLng = point;
    });
    _mapController.move(selectedLatLng!, 17);
    _updateAddress(point);
  }

  void goToMyCurrentLocation() {
    if (position == null) return;

    final current = LatLng(position!.latitude, position!.longitude);

    setState(() {
      selectedLatLng = current;
    });

    _mapController.move(current, 17);
    _updateAddress(current);
  }

  void _handleBackPressed() {
    if (_isSearching) {
      setState(() {
        _isSearching = false;
        _searchController.clear();
        _searchResults = [];
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _handleSearchToggle() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _searchResults = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          position != null && selectedLatLng != null
              ? MapWidget(
                  mapController: _mapController,
                  selectedLatLng: selectedLatLng!,
                  onTap: _onMapTap,
                )
              : const MapLoadingIndicator(),

          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Column(
              children: [
                MapSearchBar(
                  isSearching: _isSearching,
                  searchController: _searchController,
                  currentAddress: _currentAddress,
                  isLoadingAddress: _isLoadingAddress,
                  onBackPressed: _handleBackPressed,
                  onSearchToggle: _handleSearchToggle,
                ),
                if (_isSearching)
                  SearchResultsList(
                    results: _searchResults,
                    isLoading: _isLoadingSearch,
                    onLocationSelected: _selectLocation,
                  ),
              ],
            ),
          ),

          Positioned(
            bottom: 52,
            left: 16,
            right: 16,
            child: ConfirmLocationButton(position: position),
          ),
        ],
      ),
      floatingActionButton: CurrentLocationButton(
        onPressed: goToMyCurrentLocation,
      ),
    );
  }
}
