using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ActiveObjectController : MonoBehaviour
{
    private string start;
    private string targetName;

    // called zero
    void Awake()
    {
        Debug.Log("ActiveObjectController awake...");
    }

    // called first
    void OnEnable()
    {
        Debug.Log("ActiveObjectController enabled...");
        SceneManager.sceneLoaded += OnSceneLoaded;
    }

    // called second
    void OnSceneLoaded(Scene scene, LoadSceneMode mode)
    {
        
    }

    // called third
    void Start()
    {
        start = PlayerPrefs.GetString("start");
        targetName = PlayerPrefs.GetString("end");
        GameObject[] navTargets = GameObject.FindGameObjectsWithTag("NavTarget");
        foreach (GameObject navTarget in navTargets)
        {
            if (navTarget.name != targetName)
            {
                // Deactivate the NavTarget object
                navTarget.SetActive(false);
            }
        }
    }


    void Update()
    {

    }

    // called when the game is terminated
    void OnDisable()
    {
        Debug.Log("ActiveObjectController disabled...");
        SceneManager.sceneLoaded -= OnSceneLoaded;
    }
}