import 'dart:convert';
import 'dart:html';

const np8080 = 'np8080';

String getNp8080Store() {
  String result = window.localStorage[np8080];
  return result == null ? "{}" : result;
}

void saveStore(Map store) => window.localStorage[np8080] = json.encode(store);

String loadValue(String key, String defaultValue) {
  var store = getStorageAsMap();
  String value = store[key];
  if (value == null) {
    value = defaultValue;
  }
  return value;
}

Map getStorageAsMap() {
  var store = json.decode(getNp8080Store());
  return store;
}

void deleteStoredValue(String key) {
  var store = getStorageAsMap();
  store.remove(key);
  saveStore(store);
}

void storeValue(String key, String value) {
  Map store = getStorageAsMap();
  store[key] = value;
  saveStore(store);
}
