using System.Collections;
using UnityEngine;

[RequireComponent(typeof(Camera))]
public class PostProcess : MonoBehaviour
{
  public Material mat;

  public void Start()
  {
    GetComponent<Camera>().depthTextureMode |= DepthTextureMode.Depth;
  }

  [ImageEffectOpaque]
  public void OnRenderImage(RenderTexture source, RenderTexture destination)
  {
    Graphics.Blit(source, destination, mat);
  }
}