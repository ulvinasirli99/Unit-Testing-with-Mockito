
import 'package:flutter_mockito_unit_testing/model/album.dart';
import 'package:flutter_mockito_unit_testing/network/api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_album_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch Album', () {
    //Todo If Data is for Successfully..........
    test('Returns an Album if the http call completes Successfully', () async {
      final client = MockClient();

      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer(
        (_) async =>
            http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200),
      );
      expect(await fetchAlbum(client), isA<Album>());
    });

    //Todo Network Error Testing.....
    test('Throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });

}