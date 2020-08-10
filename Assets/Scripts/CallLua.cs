using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using LuaInterface;

public class CallLua : MonoBehaviour
{
    void Start()
    {
    }

    void Update()
    {
    }

    void OnGUI()
    {
        GUILayout.BeginVertical();

        GUILayout.Space(256);

        if (GUILayout.Button("Performance Test0 : Vector3 add one", GUILayout.Height(64)))
        {
            new LuaResLoader();
            LuaState lua = new LuaState();
            lua.Start();
            LuaBinder.Bind(lua);
            string hello =
                @"                
                    local GameObject = UnityEngine.GameObject
                    local Time = UnityEngine.Time

                    local _go = GameObject.FindGameObjectWithTag('MainCamera')
                    local time = Time.realtimeSinceStartup;

                    for i = 1, 200000 do
                        local v = _go.transform.position
                        _go.transform.position = Vector3.Normalize(v + Vector3.Cross(v, Vector3.one))
                    end

                    time = UnityEngine.Time.realtimeSinceStartup - time
                    print('c# Transform getset cost time: ' .. time);                          
                ";

            lua.DoString(hello, "CallLua.cs");
            lua.CheckTop();
            lua.Dispose();
            lua = null;
        }

        GUILayout.EndVertical();
    }
}
