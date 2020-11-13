// /// A circular region which represents a geofence.
// abstract class GeofenceRegion {
//   /// The ID associated with the geofence.
//   ///
//   /// This ID identifies the geofence and is required to delete a
//   /// specific geofence.
//   final String id;

//   /// The location (center point) of the geofence.
//   final Location location;

//   /// The radius around `location` that is part of the geofence.
//   final double radius;

//   /// Listen to these geofence events.
//   final List<GeofenceEvent> triggers;

//   /// Android-specific settings for a geofence.
//   final AndroidGeofencingSettings androidSettings;

//   GeofenceRegion(
//       this.id, double latitude, double longitude, this.radius, this.triggers,
//       {AndroidGeofencingSettings androidSettings});
// }
