using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.SceneManagement;

using FlutterUnityIntegration;


public class PreviewPath : MonoBehaviour
{
    private NavMeshPath path;
    private LineRenderer line;
    private GameObject startTarget;
    private GameObject endTarget;
    private Vector3 lineHeightStart;
    private Vector3 lineHeightDestination;
    private bool sceneFullyLoaded = false;
    void Start()
    {
        path = new NavMeshPath();
        line = transform.GetComponent<LineRenderer>();

        // save varibles for nagivate scene
        // int previewSceneIndex = SceneManager.GetActiveScene().buildIndex;
        // PlayerPrefs.SetInt("previousSceneIndex", previewSceneIndex);
        
    }

    void Update()
    {
         if (SceneManager.GetActiveScene().isLoaded && !sceneFullyLoaded)
        {
            // Debug.Log("Scene fully loaded.");
            // UnityMessageManager.Instance.SendMessageToFlutter("Preview Scene is fully loaded");
            sceneFullyLoaded = true;

            if (startTarget != null && endTarget != null){
            
            NavMesh.CalculatePath(startTarget.transform.position, endTarget.transform.position, NavMesh.AllAreas, path);
            line.positionCount = path.corners.Length;
            line.SetPositions(path.corners);
            }
            else{
                UnityMessageManager.Instance.SendMessageToFlutter("Display Path");
            }
        }
        
        
    }
    public void SetStartNavigationTarget(string start){
        // Find object name
        // startTarget = GameObject.Find(s);
        PlayerPrefs.SetString("start", startTarget.name);
        
    }
    public void SetEndNavigationTarget(string end){
        // Find object name
        endTarget = GameObject.Find(end);
        PlayerPrefs.SetString("end", endTarget.name);
        
    }


}