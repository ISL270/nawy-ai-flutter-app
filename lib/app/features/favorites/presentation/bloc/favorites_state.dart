import 'package:equatable/equatable.dart';
import 'package:nawy_app/app/core/models/status.dart';
import 'package:nawy_app/app/features/search/domain/models/property.dart';
import 'package:nawy_app/app/features/search/domain/models/compound.dart';

/// State for favorites feature
class FavoritesState extends Equatable {
  final VoidStatus status;
  final List<Property> favoriteProperties;
  final List<Compound> favoriteCompounds;
  final Set<int> favoritePropertyIds;
  final Set<int> favoriteCompoundIds;
  final String? errorMessage;

  const FavoritesState._({
    required this.status,
    required this.favoriteProperties,
    required this.favoriteCompounds,
    required this.favoritePropertyIds,
    required this.favoriteCompoundIds,
    this.errorMessage,
  });

  /// Initial state factory
  factory FavoritesState.initial() {
    return const FavoritesState._(
      status: Initial(),
      favoriteProperties: [],
      favoriteCompounds: [],
      favoritePropertyIds: {},
      favoriteCompoundIds: {},
    );
  }

  /// Create a copy with updated values
  FavoritesState copyWith({
    VoidStatus? status,
    List<Property>? favoriteProperties,
    List<Compound>? favoriteCompounds,
    Set<int>? favoritePropertyIds,
    Set<int>? favoriteCompoundIds,
    String? errorMessage,
  }) {
    return FavoritesState._(
      status: status ?? this.status,
      favoriteProperties: favoriteProperties ?? this.favoriteProperties,
      favoriteCompounds: favoriteCompounds ?? this.favoriteCompounds,
      favoritePropertyIds: favoritePropertyIds ?? this.favoritePropertyIds,
      favoriteCompoundIds: favoriteCompoundIds ?? this.favoriteCompoundIds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Convenience getters for state checking
  bool get isLoading => status.isLoading;
  bool get hasError => status.isFailure;
  bool get isSuccess => status.isSuccess;
  bool get hasData => favoriteProperties.isNotEmpty || favoriteCompounds.isNotEmpty;

  /// Check if a property is favorite
  bool isPropertyFavorite(int propertyId) => favoritePropertyIds.contains(propertyId);

  /// Check if a compound is favorite
  bool isCompoundFavorite(int compoundId) => favoriteCompoundIds.contains(compoundId);

  @override
  List<Object?> get props => [
        status,
        favoriteProperties,
        favoriteCompounds,
        favoritePropertyIds,
        favoriteCompoundIds,
        errorMessage,
      ];
}
