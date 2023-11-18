import '../../../core/models/autocomplete_prediction.dart';
import '../../../core/models/place_autocomplete_response.dart';
import '../../../core/services/place_api.dart';

class PlaceAutocompleteUtil {
  static Future<List<AutocompletePrediction>> placeAutocomplete(
      String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/autocomplete/json',
        {"input": query, "key": 'AIzaSyAC41qD4CKnJGwlWAXs46TPoBvxwLwc5e4'});
    String? response = await PlaceApi.fetchUrl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        return result.predictions!;
      }
    }
    return [];
  }
}
