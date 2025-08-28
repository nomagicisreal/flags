part of '../typed_data.dart';

///
///
///
/// to know the inheritance detail, see the comment above [_PFlags]
///
/// [_SplayTreeMapIntIntTypedInt]
///
///
///

// mixin _MBitsFlagsField implements _AFieldBits {
//   bool _bitOn(int position, TypedDataList<int> list) =>
//       list.pOn(position, _shift, _mask);
//
//   void _bitSet(int position, TypedDataList<int> list) =>
//       list.pSet(position, _shift, _mask);
//
//   void _bitClear(int position, TypedDataList<int> list) =>
//       list.pClear(position, _shift, _mask);
//
//   TypedDataList<int> get _newField;
//
//   TypedDataList<int> _bitSetNewField(int position) =>
//       _newField..[position >> _shift] = 1 << (position & _mask) - 1;
//
//   bool get isEmpty;
//
//   bool get isNotEmpty;
// }

// extension _SplayTreeMapIntIntTypedInt<T extends TypedDataList<int>>
//     on SplayTreeMap<int, SplayTreeMap<int, T>> {
//   ///
//   /// [_valuesAvailable]
//   ///
//   Iterable<int> _valuesAvailable(int sizeEach, int key, int keyKey) sync* {
//     final valueMap = this[key];
//     if (valueMap == null) return;
//     final values = valueMap[keyKey];
//     if (values == null) return;
//     yield* values.mapPAvailable(sizeEach, FKeep.applier);
//   }
//
//   ///
//   /// [_records], [_recordsInKey], [_recordsInKeyKey]
//   /// [_recordsWithinKeyKey]
//   /// [_recordsWithin]
//   /// [_recordsWithinValues]
//   ///
//   ///
//
//   ///
//   /// [_records]
//   /// [_recordsInKey]
//   /// [_recordsInKeyKey]
//   ///
//   Iterable<(int, int, int)> _records(int sizeEach) sync* {
//     for (var eA in entries) {
//       final key = eA.key;
//       for (var eB in eA.value.entries) {
//         final keyKey = eB.key;
//         yield* eB.value.mapPAvailable(sizeEach, (v) => (key, keyKey, v));
//       }
//     }
//   }
//
//   Iterable<(int, int, int)> _recordsInKey(int sizeEach, int key) sync* {
//     final valueMap = this[key];
//     if (valueMap == null) return;
//     for (var entry in valueMap.entries) {
//       final keyKey = entry.key;
//       yield* entry.value.mapPAvailable(sizeEach, (v) => (key, keyKey, v));
//     }
//   }
//
//   Iterable<(int, int, int)> _recordsInKeyKey(
//     int sizeEach,
//     int key,
//     int keyKey,
//   ) sync* {
//     final valueMap = this[key];
//     if (valueMap == null) return;
//     final values = valueMap[keyKey];
//     if (values == null) return;
//     yield* values.mapPAvailable(sizeEach, (v) => (key, keyKey, v));
//   }
//
//   ///
//   /// [_recordsWithinValues]
//   /// [_recordsWithinKeyKey]
//   /// [_recordsWithin]
//   ///
//   Iterable<(int, int, int)> _recordsWithinValues(
//     int sizeEach,
//     int key,
//     int keyKey,
//     int? begin,
//     int? end,
//   ) sync* {
//     final valueMap = this[key];
//     if (valueMap == null) return;
//     final values = valueMap[keyKey];
//     if (values == null) return;
//     yield* values.mapPAvailableBetween(
//       sizeEach,
//       begin,
//       end,
//       (v) => (key, keyKey, v),
//     );
//   }
//
//   Iterable<(int, int, int)> _recordsWithinKeyKey(
//     int sizeEach,
//     int key,
//     int begin,
//     int end,
//   ) sync* {
//     final valueMap = this[key];
//     if (valueMap == null) return;
//     for (
//       int? keyKey = begin;
//       keyKey != null && keyKey <= end;
//       keyKey = valueMap.firstKeyAfter(keyKey)
//     ) {
//       final values = valueMap[keyKey]!;
//       yield* values.mapPAvailable(sizeEach, (v) => (key, keyKey!, v));
//     }
//   }
//
//   Iterable<(int, int, int)> _recordsWithinKey(
//     int sizeEach,
//     int begin,
//     int end,
//   ) sync* {
//     for (
//       int? key = begin;
//       key != null && key <= end;
//       key = firstKeyAfter(key)
//     ) {
//       final valueMap = this[key]!;
//       for (var entry in valueMap.entries) {
//         final keyKey = entry.key;
//         yield* entry.value.mapPAvailable(sizeEach, (v) => (key!, keyKey, v));
//       }
//     }
//   }
//
//   Iterable<(int, int, int)> _recordsWithin(
//     int sizeEach,
//     (int, int, int) begin,
//     (int, int, int) end,
//   ) sync* {
//     final keyBegin = begin.$1;
//     final keyEnd = end.$1;
//     assert(keyBegin <= keyEnd);
//
//     final keyKeyBegin = begin.$2;
//     final keyKeyEnd = end.$2;
//     final valueBegin = begin.$3;
//     final valueEnd = end.$3;
//
//     // ==
//     if (keyEnd == keyBegin) {
//       assert(keyKeyBegin <= keyKeyEnd);
//
//       // ==
//       if (keyKeyBegin == keyKeyEnd) {
//         assert(valueBegin <= valueEnd);
//         yield* _recordsWithinValues(
//           sizeEach,
//           keyBegin,
//           keyKeyBegin,
//           valueBegin,
//           valueEnd,
//         );
//         return;
//       }
//
//       // <
//       final valueMap = this[keyBegin];
//       if (valueMap == null) return;
//
//       // keyKey begin
//       var values = valueMap[keyKeyBegin];
//       if (values != null) {
//         yield* values.mapPAvailableFrom(
//           sizeEach,
//           valueBegin,
//           (v) => (keyBegin, keyKeyBegin, v),
//         );
//       }
//
//       // keyKeys between
//       for (
//         var keyKey = valueMap.firstKeyAfter(keyKeyBegin);
//         keyKey != null && keyKey < keyKeyEnd;
//         keyKey = valueMap.firstKeyAfter(keyKey)
//       ) {
//         yield* valueMap[keyKey]!.mapPAvailable(
//           sizeEach,
//           (v) => (keyBegin, keyKey!, v),
//         );
//       }
//
//       // keyKey end
//       values = valueMap[keyKeyEnd];
//       if (values != null) {
//         yield* values.mapPAvailableTo(
//           sizeEach,
//           valueEnd,
//           (v) => (keyBegin, keyKeyEnd, v),
//         );
//       }
//       return;
//     }
//
//     // <
//     // key begin
//     var valueMap = this[keyBegin];
//     if (valueMap != null) {
//       final values = valueMap[keyKeyBegin];
//       if (values != null) {
//         yield* values.mapPAvailableFrom(
//           sizeEach,
//           valueBegin,
//           (v) => (keyBegin, keyKeyBegin, v),
//         );
//       }
//       for (
//         var keyKey = valueMap.firstKeyAfter(keyKeyBegin);
//         keyKey != null;
//         keyKey = valueMap.firstKeyAfter(keyKey)
//       ) {
//         yield* valueMap[keyKey]!.mapPAvailable(
//           sizeEach,
//           (v) => (keyBegin, keyKey!, v),
//         );
//       }
//     }
//
//     // keys between
//     for (
//       var key = firstKeyAfter(keyBegin);
//       key != null && key < keyEnd;
//       key = firstKeyAfter(key)
//     ) {
//       valueMap = this[key]!;
//       for (
//         var keyKey = valueMap.firstKey();
//         keyKey != null;
//         keyKey = valueMap.firstKeyAfter(keyKey)
//       ) {
//         yield* valueMap[keyKey]!.mapPAvailable(
//           sizeEach,
//           (v) => (key!, keyKey!, v),
//         );
//       }
//     }
//
//     // key end
//     valueMap = this[keyEnd];
//     if (valueMap != null) {
//       for (
//         var keyKey = valueMap.firstKey();
//         keyKey != null && keyKey < keyKeyEnd;
//         keyKey = valueMap.firstKeyAfter(keyKey)
//       ) {
//         yield* valueMap[keyKey]!.mapPAvailable(
//           sizeEach,
//           (v) => (keyEnd, keyKey!, v),
//         );
//       }
//       final values = valueMap[keyKeyEnd];
//       if (values == null) return;
//       yield* values.mapPAvailableTo(
//         sizeEach,
//         valueEnd,
//         (v) => (keyEnd, keyKeyEnd, v),
//       );
//     }
//   }
// }
//
