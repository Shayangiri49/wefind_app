import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive_helper.dart';

class SellPetScreen extends StatefulWidget {
  const SellPetScreen({Key? key}) : super(key: key);

  @override
  State<SellPetScreen> createState() => _SellPetScreenState();
}

class _SellPetScreenState extends State<SellPetScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _petName;
  String? _breed;
  int? _age;
  String? _location;
  String? _contactInfo;
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sell Your Pet',
          style: TextStyle(color: AppColors.whiteText),
        ),
        backgroundColor: AppColors.primaryOrange,
        iconTheme: const IconThemeData(color: AppColors.whiteText),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.responsiveValue(context, mobile: 20.0),
              vertical: ResponsiveHelper.responsiveValue(context, mobile: 12.0),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo Upload Section
                  Center(
                    child: Container(
                      width: ResponsiveHelper.responsiveValue(context, mobile: 150),
                      height: ResponsiveHelper.responsiveValue(context, mobile: 150),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.inputBorder),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 50, color: AppColors.subtleGray),
                        onPressed: () {
                          // TODO: Implement image picking
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 24)),

                  // Pet Details
                  _buildTextField(
                    context,
                    label: 'Pet Name',
                    hint: "Enter pet's name",
                    onSaved: (value) => _petName = value,
                    validator: (value) => value!.isEmpty ? "Please enter pet's name" : null,
                  ),
                  _buildTextField(
                    context,
                    label: 'Breed',
                    hint: 'e.g., Golden Retriever',
                    onSaved: (value) => _breed = value,
                  ),
                  _buildTextField(
                    context,
                    label: 'Age (Years)',
                    hint: 'e.g., 2',
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _age = int.tryParse(value!),
                    validator: (value) => value!.isEmpty || int.tryParse(value) == null ? 'Please enter a valid age' : null,
                  ),
                  _buildTextField(
                    context,
                    label: 'Location',
                    hint: 'e.g., New York, NY',
                    onSaved: (value) => _location = value,
                    validator: (value) => value!.isEmpty ? 'Please enter location' : null,
                  ),
                  _buildTextField(
                    context,
                    label: 'Contact Information',
                    hint: 'Phone number or email',
                    onSaved: (value) => _contactInfo = value,
                    validator: (value) => value!.isEmpty ? 'Please enter contact info' : null,
                  ),
                  _buildTextField(
                    context,
                    label: 'Description',
                    hint: 'Tell us about the pet (personality, habits, etc.)',
                    maxLines: 5,
                    onSaved: (value) => _description = value,
                    validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
                  ),

                  SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 32)),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // TODO: Implement form submission logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          print('Pet Name: $_petName');
                          print('Breed: $_breed');
                          print('Age: $_age');
                          print('Location: $_location');
                          print('Contact Info: $_contactInfo');
                          print('Description: $_description');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.responsiveValue(context, mobile: 40),
                          vertical: ResponsiveHelper.responsiveValue(context, mobile: 15),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'List Pet for Sale',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.responsiveValue(context, mobile: 18),
                          color: AppColors.whiteText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 24)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: ResponsiveHelper.responsiveValue(context, mobile: 16),
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 8)),
          TextFormField(
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: AppColors.inputFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.primaryOrange, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.responsiveValue(context, mobile: 16),
                vertical: ResponsiveHelper.responsiveValue(context, mobile: 12),
              ),
            ),
            onSaved: onSaved,
            validator: validator,
            style: TextStyle(
              fontSize: ResponsiveHelper.responsiveValue(context, mobile: 16),
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }
}
