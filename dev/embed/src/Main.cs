using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Networking;
using ILRuntime.Runtime.Enviorment;

namespace embed
{
    public class Main : MonoBehaviour
    {
        private static Main _ins;
        public static Main ins
        {
            get { return _ins; }
        }

        private static ILRuntime.Runtime.Enviorment.AppDomain _vm;
        public static ILRuntime.Runtime.Enviorment.AppDomain vm
        {
            get { return _vm; }
        }

        public string url = "http://192.168.73.39:4096";

        private MemoryStream _fs;
        private MemoryStream _p;
        private string _tips = "";

        void Awake()
        {
            Application.logMessageReceived += ShowTips;

            _ins = this;

            _vm = new ILRuntime.Runtime.Enviorment.AppDomain();
        }

        void Start()
        {
            StartCoroutine(LoadAndInitCore());
        }

        void Update()
        {
        }

        void OnGUI()
        {
            GUI.Label(new Rect(Screen.width / 2 - 220, Screen.height / 2 - 200, 400, 400), _tips);

            GUILayout.BeginVertical();

            if (GUILayout.Button("Load And Init", GUILayout.Height(64)))
            {
                // StartCoroutine(LoadAndInitCore());
            }

            if (GUILayout.Button("Performance Test0 : Vector3 add one", GUILayout.Height(64)))
            {
                var core = _vm.Instantiate("core.Core");
                _vm.Invoke("core.Core", "InjectGameObject", core, new object[] { this.gameObject });
                Test0();
                _vm.Invoke("core.Core", "Test0", core, null);
            }

            GUILayout.EndVertical();
        }

        void ShowTips(string msg, string stackTrace, LogType type)
        {
            _tips += msg;
            _tips += "\r\n";
        }

        private IEnumerator LoadAndInitCore()
        {
            Debug.Log("download dll from " + url);

            UnityWebRequest www_dll = UnityWebRequest.Get(String.Join("/", new string[] { url, "core.dll" }));
            yield return www_dll.SendWebRequest();
            _fs = new MemoryStream(www_dll.downloadHandler.data);

            UnityWebRequest www_pdb = UnityWebRequest.Get(String.Join("/", new string[] { url, "core.pdb" }));
            yield return www_pdb.SendWebRequest();
            _p = new MemoryStream(www_pdb.downloadHandler.data);

            _vm = new ILRuntime.Runtime.Enviorment.AppDomain();
            _vm.LoadAssembly(_fs, null, new ILRuntime.Mono.Cecil.Pdb.PdbReaderProvider());

            _vm.RegisterValueTypeBinder(typeof(Vector3), new Vector3Binder());
            _vm.RegisterValueTypeBinder(typeof(Quaternion), new QuaternionBinder());
            _vm.RegisterValueTypeBinder(typeof(Vector2), new Vector2Binder());

            // 先注释以下代码, 编译core.dll, 生成clr绑定代码后, 解注重新构建
            ILRuntime.Runtime.Generated.CLRBindings.Initialize(_vm);
        }

        public void Test0()
        {
            {
                float time = Time.realtimeSinceStartup;

                for (int i = 0; i < 200000; i++)
                {
                    Vector3 v = transform.position;
                    transform.position = Vector3.Normalize(v + Vector3.Cross(v, Vector3.one));
                }

                time = Time.realtimeSinceStartup - time;
                Debug.Log("c# Transform getset cost time: " + time);
            }
        }
    }
}
