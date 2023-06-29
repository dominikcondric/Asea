#include "CopyRenderer.h"
#include "Cala/Utility/Model.h"
#include "Cala/Rendering/Renderers/PostProcessingRenderer.h"

CopyRenderer::CopyRenderer()
{
    std::filesystem::path shadersDir(SHADERS_DIR);
    shader.attachShader(Cala::Shader::ShaderType::VertexShader, shadersDir / "PostProcessingVertexShader.glsl");
    shader.attachShader(Cala::Shader::ShaderType::FragmentShader, shadersDir / "PostProcessingFragmentShader.glsl");
    shader.createProgram();

    effectsBuffer.setData(shader.getConstantBufferInfo("EffectValues"), true);

    Cala::Model rectangleModel;
    std::vector<float> renderingQuadVertices = {
        -1.f, 1.f, 0.f, 1.f,
        -1.f, -1.f, 0.f, 0.f,
        1.f, 1.f, 1.f, 1.f,
        1.f, -1.f, 1.f, 0.f
    };

    std::vector<Cala::Model::VertexLayoutSpecification> modelLayouts;
    modelLayouts.push_back({ 0, 2, 4 * sizeof(float), 0, 1 });
    modelLayouts.push_back({ 1, 2, 4 * sizeof(float), 2 * sizeof(float), 1 });

    rectangleMesh.setVertexBufferData(renderingQuadVertices, 4, modelLayouts, false);
    rectangleMesh.setDrawingMode(Cala::Model::DrawingMode::TriangleStrip);
}

void CopyRenderer::render(Cala::GraphicsAPI *const api, QOpenGLFramebufferObject *renderingTarget, const Cala::Framebuffer *sceneToCopy)
{
    renderingTarget->bind();
    api->clearFramebuffer();
    shader.activate();
    api->disableSetting(Cala::GraphicsAPI::DepthTesting);
    api->setPolygonFillingMode(Cala::GraphicsAPI::FrontAndBack, Cala::GraphicsAPI::Fill);
    uint32_t effect = 9;
    effectsBuffer.updateData("effect", &effect, sizeof(uint32_t));
    sceneToCopy->getColorTarget(0).setForSampling(0);
    api->render(rectangleMesh);
}