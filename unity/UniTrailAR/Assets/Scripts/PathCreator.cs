using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.SceneManagement;
using FlutterUnityIntegration;

public class PathCreator : MonoBehaviour
{ 
    private NavMeshPath navMeshPath;
    private GameObject startTarget;
    private GameObject endTarget;
    public Material lineMaterial;
    public float elevationThreshold = 0.5f;
    public float lineOffset = 0.5f;
    // private bool sceneFullyLoaded = false;
    
    void Start()
    {
        // navMeshPath = new NavMeshPath();
        // startTarget = GameObject.Find("AES_225");
        // endTarget = GameObject.Find("AES_165");
        // PlayerPrefs.SetString("start", startTarget.name);
        // PlayerPrefs.SetString("end", endTarget.name);
    }

    void Update()
    {
         if (SceneManager.GetActiveScene().isLoaded)// && !sceneFullyLoaded)
        {
            // sceneFullyLoaded = true;

            if (startTarget != null && endTarget != null){
                // Calculate the path between the start and end points on the NavMesh
                navMeshPath = new NavMeshPath();
                NavMesh.CalculatePath(startTarget.transform.position, endTarget.transform.position, NavMesh.AllAreas, navMeshPath);

                // Loop through the path and create a new GameObject and Line Renderer for each segment
                for (int i = 0; i < navMeshPath.corners.Length - 1; i++){
                    // Check if the change in elevation between the current and next points is greater than the threshold
                    if (Mathf.Abs(navMeshPath.corners[i].y - navMeshPath.corners[i+1].y) > elevationThreshold){
                        continue; // Skip creating a Line Renderer for this segment
                    }
                    // Create a new empty GameObject to hold the Line Renderer
                    GameObject pathObject = new GameObject("Path " + i);

                    // Add a new Line Renderer component to the GameObject
                    LineRenderer lineRenderer = pathObject.AddComponent<LineRenderer>();
                    lineRenderer.material = lineMaterial;
                    lineRenderer.startWidth = 0.15f;
                    lineRenderer.endWidth = 0.15f;
                    // Set the start and end positions of the Line Renderer to the current and next points in the path
                    lineRenderer.positionCount = 2;
                    lineRenderer.SetPosition(0, navMeshPath.corners[i]);
                    lineRenderer.SetPosition(1, navMeshPath.corners[i + 1]);
                }
                // Loop through the path and update the position of each Line Renderer
                for (int i = 0; i < navMeshPath.corners.Length - 1; i++){
                    // Find the GameObject holding the Line Renderer for this segment of the path
                    GameObject pathObject = GameObject.Find("Path " + i);
                    if (pathObject == null){
                        continue; // Skip updating the Line Renderer for this segment
                    }
                    // Get the Line Renderer component for this segment of the path
                    LineRenderer lineRenderer = pathObject.GetComponent<LineRenderer>();
                    // Check if the change in elevation between the current and next points is greater than the threshold
                    if (Mathf.Abs(navMeshPath.corners[i].y - navMeshPath.corners[i+1].y) > elevationThreshold){
                        lineRenderer.enabled = false; // Hide the Line Renderer for this segment
                        continue;
                    }else{
                        lineRenderer.enabled = true; // Show the Line Renderer for this segment
                    }
                    // Set the start and end positions of the Line Renderer to the current and next points in the path
                    lineRenderer.SetPosition(0, navMeshPath.corners[i]);
                    lineRenderer.SetPosition(1, navMeshPath.corners[i + 1]);
                    // Add offset the the corners to increase the line height
                    navMeshPath.corners[i].y += lineOffset; 
                    navMeshPath.corners[i+1].y += lineOffset;
                }
            }
            else{
                UnityMessageManager.Instance.SendMessageToFlutter("Display Path");
            }
        }
        
    }

    
    public void SetStartNavigationTarget(string start){
        // Find object name
        startTarget = GameObject.Find(start);
        PlayerPrefs.SetString("start", startTarget.name);
        Camera mainCamera = Camera.main;
        string[] subs = start.Split('_');
        if (subs[1][0] == '1'){
            mainCamera.transform.position = new Vector3(-3.0f,6.7f,-4.1f);
        }
        else if (subs[1][0]== '2'){
            mainCamera.transform.position = new Vector3(-3.0f,18.7f,-4.1f);
        }
        else if (subs[1][0]== '3'){
            mainCamera.transform.position = new Vector3(-3.0f,30.7f,-3.8f);
        }
        else if (subs[1][0]== '4'){
            mainCamera.transform.position = new Vector3(-3.5f,43,-4.4f);
        }
        
    }
    public void SetEndNavigationTarget(string end){
        // Find object name
        endTarget = GameObject.Find(end);
        PlayerPrefs.SetString("end", endTarget.name);
        
    }

}
