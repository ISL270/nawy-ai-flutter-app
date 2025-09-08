class ApiConstants {
  static const String baseUrl = 'https://hiring-tasks.github.io/mobile-app-apis';
  
  // Endpoints
  static const String compounds = '/compounds.json';
  static const String areas = '/areas.json';
  static const String filterOptions = '/properties-get-filter-options.json';
  static const String propertiesSearch = '/properties-search.json';
  
  // Timeouts
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
}
