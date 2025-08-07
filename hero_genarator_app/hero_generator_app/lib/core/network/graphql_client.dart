import 'package:graphql_flutter/graphql_flutter.dart';
import '../constants/app_constants.dart';

class GraphQLClientProvider {
  static GraphQLClient get client {
    final HttpLink httpLink = HttpLink(graphqlBaseUrl);
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }
}
