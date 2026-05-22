
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/constants/app_strings/address_type.dart';
import 'package:coice/ui/screens/user_address/widgets/address_taking_widget/address_input_takin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AddressFormSection extends StatelessWidget {
  const AddressFormSection({
    super.key,
    required this.addressTypeController,
    required this.locationController,
    required this.fullAddressController,
    required this.phoneNumberController,
    required this.formKey,
    required this.button,
    required this.isDefault,
    required this.label,
  });

  final TextEditingController addressTypeController;
  final TextEditingController locationController;
  final TextEditingController fullAddressController;
  final TextEditingController phoneNumberController;
  final GlobalKey<FormState> formKey;
  final bool? isDefault;
  final Widget button;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandSubtle,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.surfaceWhite,
            expandedHeight: 400,
            pinned: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: AppColors.black87),
            ),
            centerTitle: true,
            title: Text(
              '$label Delivery Location',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.black87,
                letterSpacing: 0.3,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(10.9922, 76.0700),
                    initialZoom: 14,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.coice',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: const LatLng(10.9922, 76.0700),
                          width: 60,
                          height: 60,
                          child: Icon(
                            Icons.location_on_rounded,
                            color: AppColors.brand,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Material(
              child: AddressInputTakinWidget(
                isDefault: isDefault,
                addressTypeController: addressTypeController,
                addressTypes: addressTypes,
                fullAddressController: fullAddressController,
                globalKey: formKey,
                locationController: locationController,
                phoneNumberController: phoneNumberController,
                text: '$label Destination',
                button: button,
              ),
            ),
          ),
        ],
      ),
    );
  }
}