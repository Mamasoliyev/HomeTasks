import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/hero_model.dart';
import '../../../../core/network/graphql_client.dart';

abstract class HeroRemoteDataSource {
  Future<List<HeroModel>> getAllHeroes();
  Future<void> createHero(HeroModel hero);
  Future<void> updateHero(HeroModel hero);
  Future<void> deleteHero(String id);
}

class HeroRemoteDataSourceImpl implements HeroRemoteDataSource {
  final GraphQLClient client = GraphQLClientProvider.client;

  @override
  Future<List<HeroModel>> getAllHeroes() async {
    const String query = r'''
    query {
      heroes {
        id
        name
        universe
        image
      }
    }
    ''';

    final result = await client.query(QueryOptions(document: gql(query)));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data?['heroes'] as List;
    return data.map((hero) => HeroModel.fromJson(hero)).toList();
  }

  @override
  Future<void> createHero(HeroModel hero) async {
    const String mutation = r'''
    mutation CreateHero($name: String!, $universe: String!, $image: String!) {
      createHero(name: $name, universe: $universe, image: $image) {
        id
      }
    }
    ''';

    final result = await client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {
          'name': hero.name,
          'universe': hero.universe,
          'image': hero.image,
        },
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<void> updateHero(HeroModel hero) async {
    const String mutation = r'''
    mutation UpdateHero($id: ID!, $name: String!, $universe: String!, $image: String!) {
      updateHero(id: $id, name: $name, universe: $universe, image: $image) {
        id
      }
    }
    ''';

    final result = await client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {
          'id': hero.id,
          'name': hero.name,
          'universe': hero.universe,
          'image': hero.image,
        },
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<void> deleteHero(String id) async {
    const String mutation = r'''
    mutation DeleteHero($id: ID!) {
      deleteHero(id: $id)
    }
    ''';

    final result = await client.mutate(
      MutationOptions(document: gql(mutation), variables: {'id': id}),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
  }
}
