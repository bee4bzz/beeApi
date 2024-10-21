import 'package:equatable/equatable.dart';

/// [ElementApi] defines a generic interface for managing elements
/// in a data source. This can be extended to work with different types
/// of elements that extend [Equatable].
abstract class ElementApi<T extends Element> {
  /// Fetches a list of all elements from the data source.
  ///
  /// Returns a [Future] containing a list of [T] elements.
  Future<Map<String, T>> fetchAll();

  /// Saves a single element to the data source.
  ///
  /// If an element with the same identifier already exists, it will be replaced.
  ///
  /// Parameters:
  /// - [element]: The element to be saved.
  ///
  /// Returns a [Future] containing the updated list of elements after saving.
  Future<Map<String, T>> save({
    required final T element,
  });

  /// Saves a list of elements to the data source.
  ///
  /// If elements with the same identifiers already exist, they will be replaced.
  ///
  /// Parameters:
  /// - [elements]: The list of elements to be saved.
  ///
  /// Returns a [Future] containing the updated list of elements after saving.
  Future<Map<String, T>> saveAll({
    required final Map<String, T> elements,
  });

  /// Deletes elements from the data source based on the id.
  ///
  /// Parameters:
  /// - [id]: The primary key of the element to be deleted.
  ///
  /// If no element is found with the given key, an [ElementException] is thrown.
  ///
  /// Returns a [Future] containing the updated list of elements after deletion.
  Future<Map<String, T>> delete({
    required String id,
  });

  /// Closes the repository and releases any resources.
  ///
  /// This should be called when the repository is no longer needed.
  Future<void> close();
}

/// Enum representing different types of failures that can occur in the
/// [ElementApi].
enum ElementFailureCode {
  /// Represents an unknown error.
  unknown,

  /// Indicates that the requested element was not found.
  elementNotFound,
}

/// Custom exception thrown when an error occurs in the [ElementApi].
///
/// The exception carries a failure code to indicate the specific reason
/// for the failure.
class ElementException extends Equatable implements Exception {
  /// Constructs an [ElementException] with an optional failure code.
  ///
  /// The default failure code is [ElementFailureCode.unknown].
  const ElementException({
    this.code = ElementFailureCode.unknown,
  });

  /// The failure code associated with this exception.
  final ElementFailureCode code;

  @override
  List<Object?> get props => [code];
}

abstract class Element extends Equatable {
  const Element({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson();
}
