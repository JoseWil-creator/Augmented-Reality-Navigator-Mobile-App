using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class NotificationTrigger : MonoBehaviour
{
    private GameObject destination;
    private GameObject notificationPanel;
    private TextMeshProUGUI notificationText;
    private Canvas canvas;
    private GameObject navArrow;

    private bool notificationTriggered = false;

    void Start() {
        notificationPanel = GameObject.Find("NotificationPanel");
        notificationPanel.SetActive(false);
        destination = GameObject.Find(PlayerPrefs.GetString("end"));
        navArrow = GameObject.Find("NavArrowV2");
    }

    void Update()
    {
        if (destination == null)
        {
            Debug.Log("Destination not found");
            destination = GameObject.Find(PlayerPrefs.GetString("end"));
        }
        if (notificationPanel == null)
        {
            Debug.Log("Notification panel not found");
            notificationPanel = GameObject.Find("NotificationPanel");
        }
        // Debug.Log(Vector3.Distance(transform.position, destination.transform.position));
        if (!notificationTriggered && Vector3.Distance(transform.position, destination.transform.position) < 2.0f && destination != null && notificationPanel != null)
        {
            // Debug.Log(Vector3.Distance(transform.position, destination.transform.position));
            notificationPanel.SetActive(true);
            notificationTriggered = true;
            navArrow.SetActive(false);
            PlayerPrefs.SetString("activeNav", "false");
        }
    }

    public void CloseNotification()
    {
        notificationPanel.SetActive(false);
        notificationTriggered = false;
    }
}
