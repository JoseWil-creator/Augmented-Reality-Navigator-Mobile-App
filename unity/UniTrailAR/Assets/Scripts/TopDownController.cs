using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Animations;

public class TopDownController : MonoBehaviour
{
    private GameObject topDownCamHolder;
    private PositionConstraint positionConstraint;
    private Transform mainCam;
    private string currentFloor;
    private string newFloor;
    public float interval = 1.0f;
    private float timer = 0.0f;


    // Start is called before the first frame update
    void Start()
    {
        // topDownCamHolder = GameObject.Find("TopDownCamHolder");
        // Debug.Log("topDownCamHolder found");
        mainCam = GameObject.Find("PlayerV2").transform;
        Debug.Log("mainCam found");
        positionConstraint = GetComponent<PositionConstraint>();
        Debug.Log("positionConstraint found");
    }

    void CheckFloorAndUpdate()
    {   
        //transform.TransformPoint(transform.position)
        // if (mainCam.position.y < 5.6f)
        Debug.Log("mainCam position: " + mainCam.position);
        if (mainCam.position.y < 4.0f)
        {
            transform.position = new Vector3(transform.position.x, 6.1f, transform.position.z);
            if (PlayerPrefs.GetString("currentFloor") != "1")
            {
                PlayerPrefs.SetString("currentFloor", "1");
                Debug.Log("Current floor updated to " + PlayerPrefs.GetString("currentFloor"));
            }
        }
        else
        {
            transform.position = new Vector3(transform.position.x, 13.5f, transform.position.z);
            if (PlayerPrefs.GetString("currentFloor") != "2")
            {
                PlayerPrefs.SetString("currentFloor", "2");
                Debug.Log("Current floor updated to " + PlayerPrefs.GetString("currentFloor"));
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        // timer += Time.deltaTime;
        // if (timer > interval)
        // {
        //     CheckFloorAndUpdate();
        //     timer = 0.0f;
        // }
        CheckFloorAndUpdate();
    }
}
