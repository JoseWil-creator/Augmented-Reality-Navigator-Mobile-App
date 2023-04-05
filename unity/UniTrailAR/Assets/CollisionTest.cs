using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionTest : MonoBehaviour
{
    void OnTriggerEnter(Collider other)
    {
        Debug.Log("Collision detected");
    }

    void OnCollisionEnter(Collision collision)
    {
        Debug.Log("Collision detected");
    }
}
