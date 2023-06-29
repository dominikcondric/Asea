#include "Cala/Rendering/Mesh.h"
#include "Cala/Rendering/Shader.h"
#include "Cala/Rendering/GraphicsAPI.h"
#include <QOpenGLFramebufferObject>

class CopyRenderer {
public:
    CopyRenderer();
    ~CopyRenderer() = default;
    void render(Cala::GraphicsAPI* const api, QOpenGLFramebufferObject* renderingTarget, const Cala::Framebuffer* sceneToCopy);

private:
    Cala::Mesh rectangleMesh;
    Cala::Shader shader;
    Cala::ConstantBuffer effectsBuffer;
};