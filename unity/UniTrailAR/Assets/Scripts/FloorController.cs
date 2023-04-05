using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class FloorController : MonoBehaviour
{
    public void SwitchFloor(Button button){
        Camera mainCamera = Camera.main;
        if (button.gameObject.name == "FloorOne"){
            mainCamera.transform.position = new Vector3(-3.0f,6.7f,-4.1f);
        }
        else if (button.gameObject.name == "FloorTwo"){
            mainCamera.transform.position = new Vector3(-3.0f,18.7f,-4.1f);
        }
        else if (button.gameObject.name == "FloorThree"){
            mainCamera.transform.position = new Vector3(-3.0f,30.7f,-3.8f);
        }
        else if (button.gameObject.name == "FloorFour"){
            mainCamera.transform.position = new Vector3(-3.5f,43,-4.4f);
        }
    }
}
