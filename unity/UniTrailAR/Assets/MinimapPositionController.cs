using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MinimapPositionController : MonoBehaviour
{
    private RawImage rawImage;

    void Start()
    {
        // Find the child RawImage component
        rawImage = GetComponentInChildren<RawImage>();

        // Set the position of the RawImage to 20 pixels above the bottom of the screen
        RectTransform rt = rawImage.rectTransform;
        rt.anchoredPosition = new Vector2(rt.anchoredPosition.x, rt.rect.height / 2 + 20);
    }
}
