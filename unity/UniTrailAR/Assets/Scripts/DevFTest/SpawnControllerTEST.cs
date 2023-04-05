using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.AI;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.XR.ARFoundation;
using Unity.XR.CoreUtils;


public class SpawnControllerTEST : MonoBehaviour
{
    // XROrigin xrOrigin;
    private Transform spawnPoint;
    private Transform target;
    private Transform xrOrigin;
    private string start;
    private string end;
    public static bool isSpawned = false;

    // called zero
    void Awake()
    {
        Debug.Log("Awake");
        // PlayerPrefs.SetString("start", "AES_237");
        // PlayerPrefs.SetString("end", "AES_195");
        PlayerPrefs.SetString("currentFloor", "2");
        start = PlayerPrefs.GetString("start");
        end = PlayerPrefs.GetString("end");
        // start = "AES_237";
        // end = "AES_EXIT";
    }

    // called first
    void OnEnable()
    {
        Debug.Log("OnEnable called");
        SceneManager.sceneLoaded += OnSceneLoaded;
    }

    // called second
    void OnSceneLoaded(Scene scene, LoadSceneMode mode)
    {
        Debug.Log("OnSceneLoaded: " + scene.name);
        Debug.Log(mode);
        spawnPoint = GameObject.Find(start).transform;
        target = GameObject.Find(end).transform;
        xrOrigin = GameObject.Find("XR Origin").transform;

        if (spawnPoint != null)
        {
            Debug.Log("Spawn point found");
        }
        else
        {
            Debug.Log("Spawn point not found");
        }
        if (target != null)
        {
            Debug.Log("Target found");
        }
        else
        {
            Debug.Log("Target not found");
        }
    }

    // called third
    void Start()
    {
        Debug.Log("Start");
        xrOrigin.position = spawnPoint.position;
        PlayerPrefs.SetString("activeNav", "true");
    }

    // called when the game is terminated
    void OnDisable()
    {
        Debug.Log("OnDisable");
        SceneManager.sceneLoaded -= OnSceneLoaded;
    }
}