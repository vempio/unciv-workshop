# Unciv Notification System — Quick Reference

## Notification Class

```kotlin
class Notification : Json.Serializable {
    var category: NotificationCategory = NotificationCategory.General
    var text: String = ""
    var icons: ArrayList<String> = ArrayList()
    var actions: ArrayList<NotificationAction> = ArrayList()
}
```

## NotificationCategory Enum

```kotlin
enum class NotificationCategory {
    General,
    Trade,
    Diplomacy,
    Production,
    Units,
    War,
    Religion,
    Espionage,
    Cities
}
```

## Where Notifications Live

In `Civilization.kt`:

```kotlin
/** Current turn's notifications */
val notifications = ArrayList<Notification>()

/** Historical notifications, grouped by turn */
val notificationsLog = ArrayList<NotificationsLog>()
```

The history wrapper:

```kotlin
class NotificationsLog(
    val turn: Int,
    val notifications: ArrayList<Notification>
)
```

## Example: Creating a Notification

```kotlin
civilization.addNotification(
    "You have discovered [Pottery]!",
    NotificationCategory.General,
    "TechIcons/Pottery"
)
```

## Your Task

Filter notifications by category. Support both:

1. Current turn: `civilization.notifications`
2. History: `civilization.notificationsLog`

---

*Full source: `core/src/com/unciv/logic/civilization/Notification.kt`*
