import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

// final HttpLink httpLink = HttpLink('http://192.168.187.12:8002/graphql/'); // aniket's wifi
final HttpLink httpLink = HttpLink('http://192.168.0.116:8002/graphql/'); // home's bedroom wifi
// final HttpLink httpLink = HttpLink('http://192.168.208.12:8002/graphql/'); // bhanushali's wifi
// final HttpLink httpLink = HttpLink('http://192.168.92.12:8002/graphql/'); // aniket's wifi
// final HttpLink httpLink = HttpLink('http://192.168.160.12:8002/graphql/'); // tanvi's wifi

final httpImage = 'http://192.168.160.12:8002/media/';

final ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  ),
);