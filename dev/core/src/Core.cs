using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

using embed;

namespace core
{
    public class Core
    {
        private GameObject _go;
        public void InjectGameObject(GameObject go)
        {
            _go = go;
        }

        public void Test0()
        {

            {
                Main.ins.Test0();

                float time = Time.realtimeSinceStartup;

                for (int i = 0; i < 200000; i++)
                {
                    Vector3 v = _go.transform.position;
                    _go.transform.position = Vector3.Normalize(v + Vector3.Cross(v, Vector3.one));
                }

                time = Time.realtimeSinceStartup - time;
                Debug.Log("c# Transform getset cost time: " + time);
            }
        }
    }
}