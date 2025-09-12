import 'package:firebase_ai/firebase_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:nawy_app/app/features/property_search/domain/property_search_repository.dart';

@singleton
class AiService {
  final PropertySearchRepository _propertyRepository;
  late final GenerativeModel _model;

  AiService(this._propertyRepository) {
    _initializeModel();
  }

  void _initializeModel() {
    // Define function declarations for property search
    final searchPropertiesFunction = FunctionDeclaration(
      'searchProperties',
      'Search for real estate properties based on user criteria. This function can filter properties by location (area/compound), price range, number of bedrooms, and property type.',
      parameters: {
        'searchQuery': Schema.string(
          description: 'General search query or keywords for property search',
        ),
        'areaIds': Schema.array(
          description: 'List of area IDs to filter properties by location',
          items: Schema.integer(),
        ),
        'compoundIds': Schema.array(
          description: 'List of compound IDs to filter properties by specific compounds',
          items: Schema.integer(),
        ),
        'minPrice': Schema.integer(description: 'Minimum price filter for properties in EGP'),
        'maxPrice': Schema.integer(description: 'Maximum price filter for properties in EGP'),
        'minBedrooms': Schema.integer(description: 'Minimum number of bedrooms required'),
        'maxBedrooms': Schema.integer(description: 'Maximum number of bedrooms required'),
        'propertyTypeIds': Schema.array(
          description: 'List of property type IDs (e.g., apartment, villa, townhouse)',
          items: Schema.integer(),
        ),
      },
    );

    final getAreasFunction = FunctionDeclaration(
      'getAreas',
      'Get all available areas/locations where properties are available. Use this to help users understand available locations.',
      parameters: {},
    );

    final getCompoundsFunction = FunctionDeclaration(
      'getCompounds',
      'Get all available compounds/developments. Use this to help users find specific compounds or developments.',
      parameters: {},
    );

    final getFilterOptionsFunction = FunctionDeclaration(
      'getFilterOptions',
      'Get all available filter options including property types, price ranges, and other filtering criteria.',
      parameters: {},
    );

    // Initialize Gemini 2.5 Pro with function declarations
    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-pro',
      tools: [
        Tool.functionDeclarations([
          searchPropertiesFunction,
          getAreasFunction,
          getCompoundsFunction,
          getFilterOptionsFunction,
        ]),
      ],
      systemInstruction: Content.system('''
      You are a helpful real estate assistant for Nawy, Egypt's leading real estate platform. 
      You help users find their perfect property by understanding their needs and searching through available properties.

      Available functions:
      - searchProperties: Search for properties with filters
      - getAreas: Get all available areas/locations
      - getCompounds: Get all available compounds/developments  
      - getFilterOptions: Get available filter options

      Key guidelines:
      - Always be friendly and professional
      - Ask clarifying questions when user requirements are unclear
      - Use ONLY the exact function names provided above
      - Provide detailed property information including price, location, bedrooms, and key features
      - Help users understand different areas and compounds in Egypt
      - Convert between different price formats (e.g., millions to actual numbers)
      - Be knowledgeable about Egyptian real estate market

      When users ask about properties, use the functions to find relevant results and present them in a clear, organized way.
      '''),
    );
  }

  ChatSession startNewChat() {
    return _model.startChat();
  }

  Future<GenerateContentResponse> sendMessage(ChatSession chat, String message) async {
    var response = await chat.sendMessage(Content.text(message));

    // Handle function calls
    final functionCalls = response.functionCalls.toList();
    if (functionCalls.isNotEmpty) {
      for (final functionCall in functionCalls) {
        final functionResult = await _handleFunctionCall(functionCall);

        // Send function result back to model
        response = await chat.sendMessage(
          Content.functionResponse(functionCall.name, functionResult),
        );
      }
    }

    return response;
  }

  Future<Map<String, dynamic>> _handleFunctionCall(FunctionCall functionCall) async {
    switch (functionCall.name) {
      case 'searchProperties':
        final args = functionCall.args;
        final searchResponse = await _propertyRepository.searchProperties(
          searchQuery: args['searchQuery'] as String?,
          areaIds: (args['areaIds'] as List<dynamic>?)?.cast<int>(),
          compoundIds: (args['compoundIds'] as List<dynamic>?)?.cast<int>(),
          minPrice: args['minPrice'] as int?,
          maxPrice: args['maxPrice'] as int?,
          minBedrooms: args['minBedrooms'] as int?,
          maxBedrooms: args['maxBedrooms'] as int?,
          propertyTypeIds: (args['propertyTypeIds'] as List<dynamic>?)?.cast<int>(),
        );

        return {
          'properties': searchResponse.properties
              .map(
                (property) => {
                  'id': property.id,
                  'name': property.name,
                  'area': property.area?.name,
                  'compound': property.compound?.name,
                  'developer': property.developer?.name,
                  'propertyType': property.propertyType?.name,
                  'minPrice': property.minPrice,
                  'maxPrice': property.maxPrice,
                  'currency': property.currency,
                  'numberOfBedrooms': property.numberOfBedrooms,
                  'numberOfBathrooms': property.numberOfBathrooms,
                  'minUnitArea': property.minUnitArea,
                  'maxUnitArea': property.maxUnitArea,
                  'finishing': property.finishing,
                  'newProperty': property.newProperty,
                  'resale': property.resale,
                  'financing': property.financing,
                  'hasOffers': property.hasOffers,
                  'offerTitle': property.offerTitle,
                },
              )
              .toList(),
          'totalCount': searchResponse.totalProperties,
        };

      case 'getAreas':
        final areas = await _propertyRepository.getAreas();
        return {
          'areas': areas
              .map((area) => {'id': area.id, 'name': area.name, 'slug': area.slug})
              .toList(),
        };

      case 'getCompounds':
        final compounds = await _propertyRepository.getCompounds();
        return {
          'compounds': compounds
              .map((compound) => {'id': compound.id, 'name': compound.name, 'slug': compound.slug})
              .toList(),
        };

      case 'getFilterOptions':
        final filterOptions = await _propertyRepository.getFilterOptions();
        return {
          'propertyTypes':
              filterOptions.propertyTypes
                  ?.map((type) => {'id': type.id, 'name': type.name})
                  .toList() ??
              [],
          'minPriceList': filterOptions.minPriceList,
          'maxPriceList': filterOptions.maxPriceList,
          'minBedrooms': filterOptions.minBedrooms,
          'maxBedrooms': filterOptions.maxBedrooms,
        };

      default:
        throw UnimplementedError('Function not implemented: ${functionCall.name}');
    }
  }
}
