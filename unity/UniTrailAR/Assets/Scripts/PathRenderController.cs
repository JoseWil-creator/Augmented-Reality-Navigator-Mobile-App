using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class PathRenderController : MonoBehaviour
{
    // Find the path origin and destination
    // Draw the path and update continuously
    private Transform start;
    private Transform end;
    private Transform mainCamera;
    private NavMeshPath path;
    private LineRenderer line;
    private GameObject navArrow3D;
    private int nextCornerIndex;
    private int nextNextCornerIndex;

    // Start is called before the first frame update
    void Start()
    {
        start = GameObject.Find("PlayerV2").transform;
        end = GameObject.Find(PlayerPrefs.GetString("end")).transform;
        navArrow3D = GameObject.Find("NavArrowHolder");
        mainCamera = GameObject.Find("Main Camera").transform;
        path = new NavMeshPath();
        nextCornerIndex = 1;
        nextNextCornerIndex = 2;
        line = GetComponent<LineRenderer>();
    }

    // Update is called once per frame
    void Update()
    {
        DrawPath();
    }

    void DrawPath()
    {
        NavMesh.CalculatePath(start.position, end.position, NavMesh.AllAreas, path);
        // Debug.Log("Path corners: " + path.corners.Length);
        if (path == null || path.corners.Length < 2)
        {
            return;
        }
        line.positionCount = path.corners.Length;
        for (int i = 0; i < path.corners.Length; i++)
        {
            path.corners[i] = new Vector3(path.corners[i].x, path.corners[i].y + .2f, path.corners[i].z);
        }
        line.SetPositions(path.corners);
        UpdateArrowPosition();
        PointArrow();
    }

    void UpdateArrowPosition()
    {
        if (path == null || path.corners.Length < 2)
        {
            return;
        }
        // Get the next corner
        Vector3 nextCornerPos = path.corners[nextCornerIndex];
        Vector3 direction = (nextCornerPos - start.position).normalized;
        Vector3 cameraPosition = mainCamera.position;
        Vector3 cameraDirection = mainCamera.forward;

        // Place the arrow between the player and the next corner
        // navArrow3D.transform.position = start.position + direction * 3.0f;
        // navArrow3D.transform.position = new Vector3(navArrow3D.transform.position.x, navArrow3D.transform.position.y + 0.0f, navArrow3D.transform.position.z);
        
        // Place the arrow in front of the camera instead of between the player and the next corner
        navArrow3D.transform.position = cameraPosition + cameraDirection * 3.0f;
        navArrow3D.transform.position = new Vector3(navArrow3D.transform.position.x, navArrow3D.transform.position.y - 1.0f, navArrow3D.transform.position.z);
    }

    void PointArrow()
    {
        if (path == null || path.corners.Length < 2)
        {
            return;
        }
        // Get the next corner
        Vector3 nextCornerPos = path.corners[nextCornerIndex];
        // Get the direction to the next corner
        Vector3 direction = nextCornerPos - start.position;
        // Get distance to the next corner
        float distance = direction.magnitude;
        // If the distance is less than 3.0f, then we have reached the corner
        if (distance < 3.5f)
        {
            nextCornerPos = path.corners[nextNextCornerIndex];
            direction = nextCornerPos - start.position;
            Quaternion rotation = Quaternion.LookRotation(direction, Vector3.up);
            navArrow3D.transform.rotation = rotation;
        }
        else
        {
            Quaternion rotation = Quaternion.LookRotation(direction, Vector3.up);
            navArrow3D.transform.rotation = rotation;
        }

    }
}
