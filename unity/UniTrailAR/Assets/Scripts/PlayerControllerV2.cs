using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.XR.ARFoundation;
using Unity.XR.CoreUtils;
using UnityEngine.AI;

public class PlayerControllerV2 : MonoBehaviour
{
    public ARCameraManager arCameraManager;

    // Update is called once per frame
    void Update()
    {
        Transform cameraTransform = arCameraManager.GetComponent<Camera>().transform;
        Quaternion cameraRotation = Quaternion.Euler(0, cameraTransform.eulerAngles.y, 0);
        transform.rotation = cameraRotation;
    }
}
